//
//  TmdbListBaseViewController.swift
//  VirgoProject
//
//  Created by Administrator on 24/05/22.
//

import UIKit

class TmdbListBaseViewController: UIViewController, ListTrendingViewDelegate, ListDiscoverViewDelegate, ErrorViewDelegate {
    
    var safeAreaInsetMargin: CGFloat = 0
    
    lazy var indicatorView: UIActivityIndicatorView = {
        let indicator: UIActivityIndicatorView = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    lazy var errorView: ErrorView = {
        let errorView: ErrorView = ErrorView()
        errorView.delegate = self
        errorView.translatesAutoresizingMaskIntoConstraints = false
        return errorView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView: UIScrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let view: UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var headerView: HeaderView = {
        let header: HeaderView = HeaderView()
        header.translatesAutoresizingMaskIntoConstraints = false
        return header
    }()
    
    lazy var listTrendingView: ListTrendingView = {
        let listView: ListTrendingView = ListTrendingView()
        listView.delegate = self
        listView.translatesAutoresizingMaskIntoConstraints = false
        return listView
    }()
    
    lazy var listDiscoverView: ListDiscoverView = {
        let listView: ListDiscoverView = ListDiscoverView()
        listView.delegate = self
        listView.translatesAutoresizingMaskIntoConstraints = false
        return listView
    }()
    
    open func selectedTrendingItem(index: Int) { }
    open func selectedDiscoverItem(index: Int) { }
    open func actionRetryButton() { }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setupViews() {
        view.backgroundColor = UIColor(named: "primary_color")
        
        navigationController?.navigationBar.barTintColor = UIColor(named: "primary_color")
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        setSafeAreaInsetMargin()
        
        view.addSubview(errorView)
        view.addSubview(indicatorView)
        
        contentView.addSubview(headerView)
        contentView.addSubview(listTrendingView)
        contentView.addSubview(listDiscoverView)
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.bounces = false
    }
    
    func setupLayouts() {
        NSLayoutConstraint.activate([
            indicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            errorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ])
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            listTrendingView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: Margin.maximumMargin),
            listTrendingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            listTrendingView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            listDiscoverView.topAnchor.constraint(equalTo: listTrendingView.bottomAnchor, constant: Margin.mainMargin),
            listDiscoverView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            listDiscoverView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            listDiscoverView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Margin.mainMargin)
        ])
    }
    
    func setSafeAreaInsetMargin () {
        guard let window = setupGetKeyWindow() else {
            safeAreaInsetMargin = 0
            return
        }
        
        safeAreaInsetMargin = window.safeAreaInsets.bottom + window.safeAreaInsets.top + Margin.mainMargin
    }
    
    func didSelectedTrendingItem(withIndex index: Int) {
        selectedTrendingItem(index: index)
    }
    
    func didSelectedDiscoverItem(withIndex index: Int) {
        selectedDiscoverItem(index: index)
    }
    
    func didTapRetryButton() {
        actionRetryButton()
    }
    
    func setupStateView(state: StateView) {
        switch state {
        case .showIndicator:
            indicatorView.startAnimating()
            indicatorView.isHidden = false
            scrollView.isHidden = true
            errorView.isHidden = true
            
        case .showContent:
            scrollView.isHidden = false
            errorView.isHidden = true
            indicatorView.stopAnimating()
            
        case .showError:
            DispatchQueue.main.async {
                self.indicatorView.stopAnimating()
                self.indicatorView.isHidden = true
                self.errorView.isHidden = false
                self.scrollView.isHidden = true
            }
        }
    }
}

extension TmdbListBaseViewController {
    func setupGetKeyWindow() -> UIWindow? {
        if #available(iOS 13.0, *) {
            let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .compactMap({$0 as? UIWindowScene})
                .first?.windows
                .filter({$0.isKeyWindow}).first
            return keyWindow
        } else {
            return UIApplication.shared.keyWindow
        }
    }
    
    func setupIndicatorView() {
        if #available(iOS 13.0, *) {
            self.indicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        } else {
            self.indicatorView = UIActivityIndicatorView(style: .whiteLarge)
        }
        
        self.indicatorView.color = .white
        self.indicatorView.center = view.center
        self.indicatorView.hidesWhenStopped = true
    }
}
