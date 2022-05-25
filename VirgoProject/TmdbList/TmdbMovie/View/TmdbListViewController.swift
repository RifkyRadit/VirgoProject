//
//  TmdbListViewController.swift
//  VirgoProject
//
//  Created by Administrator on 23/05/22.
//

import UIKit

protocol TmdbListViewControllerDelegate: AnyObject {
    func didActive(viewController: UIViewController)
}

class TmdbListViewController: TmdbListBaseViewController {

    weak var delegate: TmdbListViewControllerDelegate?
    var presenter: ViewToPresenterListProtocol?
    var errorCheck: [Bool] = []
    
    var moviesData: [MoviesResult] = [] {
        didSet {
            setupHeaderView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupStateView(state: .showIndicator)
        setupViews()
        setupLayouts()
        presenter?.viewDidLoad()
        actionCheckError()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        errorCheck = []
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let delegate = delegate else {
            return
        }
        
        delegate.didActive(viewController: self)
    }
    
    func setupHeaderView() {
        if let firstItem = self.moviesData.first {
            headerView.addHeaderViewComponent(imageUrl: firstItem.backdropPath, title: firstItem.title)
        }
    }
    
    override func selectedTrendingItem(index: Int) {
        presenter?.didSelectRowAt(index: index, stateMovies: .trendingMovies())
    }
    
    override func selectedDiscoverItem(index: Int) {
        presenter?.didSelectRowAt(index: index, stateMovies: .discoverMovies())
    }
    
    override func actionRetryButton() {
        presenter?.viewDidLoad()
    }
    
    func actionCheckError() {
        DispatchQueue.main.async {
            if !self.errorCheck.isEmpty, self.errorCheck.allSatisfy({ $0 == true }) {
                self.setupStateView(state: .showError)
            } else {
                self.setupStateView(state: .showContent)
            }
        }
        
    }
}

extension TmdbListViewController: PresenterToViewListProtocol {
    func onFetchTrendingSuccess(moviesData: [MoviesResult]) {
        errorCheck.append(false)
        self.moviesData = moviesData
        self.listTrendingView.setContenListTrending(withData: moviesData)
        
    }
    
    func onFetchDiscoverSuccess(moviesData: [DiscoverMovieResult]) {
        errorCheck.append(false)
        self.listDiscoverView.setContenListDiscover(withData: moviesData)
        setupStateView(state: .showContent)
    }
    
    func onFetchFailure() {
        errorCheck.append(true)
        setupStateView(state: .showError)
    }
}
