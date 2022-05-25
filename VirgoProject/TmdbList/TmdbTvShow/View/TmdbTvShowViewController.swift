//
//  TmdbTvShowViewController.swift
//  VirgoProject
//
//  Created by Administrator on 24/05/22.
//

import UIKit

protocol TmdbTvShowViewControllerDelegate: AnyObject {
    func didActive(viewController: UIViewController)
}

class TmdbTvShowViewController: UIViewController {

    weak var delegate: TmdbTvShowViewControllerDelegate?
    var presenter: ViewToPresenterTvShowProtocol?
    var pageNumber = 1
    
    lazy var refreshControl: UIRefreshControl = {
        let refresh: UIRefreshControl = UIRefreshControl()
        refresh.tintColor = UIColor.white
        refresh.translatesAutoresizingMaskIntoConstraints = false
        return refresh
    }()
    
    lazy var collectionView: UICollectionView = {
        let list: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        list.translatesAutoresizingMaskIntoConstraints = false
        return list
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupLayout()
        presenter?.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let delegate = delegate else {
            return
        }
        
        delegate.didActive(viewController: self)
    }
    
    func setupView() {
        view.backgroundColor = UIColor(named: "primary_color")
        
        view.addSubview(collectionView)
        setupCollectionView()
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.mainMargin),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Margin.mainMargin),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Margin.mainMargin)
        ])
    }
    
    func setupCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.register(UINib(nibName: "ListTvShowCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = collectionViewFlowLayout()
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(actionRefreshControl(_:)), for: .valueChanged)
    }
    
    func collectionViewFlowLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 8
        flowLayout.minimumLineSpacing = 8
        flowLayout.scrollDirection = .vertical
        
        return flowLayout
    }
    
    @objc
    func actionRefreshControl(_ sender: UIRefreshControl) {
        sender.endRefreshing()
        presenter?.viewDidLoad()
    }
}

extension TmdbTvShowViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfItemsInSection() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: ListTvShowCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ListTvShowCell else {
            return UICollectionViewCell()
        }
        
        cell.setPosterImage(urlString: presenter?.listTvShowPoster(indexPath: indexPath))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let `presenter` = presenter, indexPath.row == presenter.numberOfItemsInSection() - 1 else {
            return
        }
        
        self.pageNumber += 1
        presenter.loadMoreTvShow(pageNumber: pageNumber)
    }
}

extension TmdbTvShowViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = collectionView.frame.size.height / 2
        return CGSize(width:(collectionView.bounds.width-8)/2, height: height)
    }
}

extension TmdbTvShowViewController: PresenterToViewTvShowProtocol {
    func onFetchSuccess() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func onFetchFailure() {
        
    }
}
