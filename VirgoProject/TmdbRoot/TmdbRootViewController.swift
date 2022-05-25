//
//  TmdbRootViewController.swift
//  VirgoProject
//
//  Created by Administrator on 24/05/22.
//

import UIKit

class TmdbRootViewController: UIPageViewController {

    
    var currentIndex: Int = 0
    
    lazy var ITEMS_VC: [UIViewController] = {
        var tmdbItems: [UIViewController] = [UIViewController]()
        
        let movies = TmdbListRouter.createModule() as? TmdbListViewController
        movies?.view.tag = 0
        movies?.delegate = self
        tmdbItems.append(movies ?? UIViewController())
        
        let tvShows = TmdbTvShowRouter.createModule() as? TmdbTvShowViewController
        tvShows?.delegate = self
        tvShows?.view.tag = 1
        tmdbItems.append(tvShows ?? UIViewController())
        
        return tmdbItems
    }()
    
    lazy var tabSegmented: TabSegmentedControl = {
        let tabView: TabSegmentedControl = TabSegmentedControl(items: ["Movies", "TV Show"])
        tabView.delegate = self
        tabView.translatesAutoresizingMaskIntoConstraints = false
        return tabView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupLayout()
        setupItemFirst()
        dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func setupView() {
        view.backgroundColor = UIColor(named: "primary_color")
        view.addSubview(tabSegmented)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            tabSegmented.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tabSegmented.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabSegmented.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabSegmented.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func setupItemFirst() {
        guard let contentController = ITEMS_VC.first else {
            return
        }
        
        setViewControllers([contentController], direction: .forward, animated: true, completion: nil)
    }
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TmdbRootViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let selectedVC = viewController as? TmdbTvShowViewController else {
            return nil
        }
        
        let prevIndex = selectedVC.view.tag - 1
        
        guard prevIndex >= 0 else {
            return nil
        }
        
        return ITEMS_VC[prevIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let selectedVC = viewController as? TmdbListViewController else {
            return nil
        }
        
        let nextIndex = selectedVC.view.tag + 1
        
        guard nextIndex < ITEMS_VC.count else {
            return nil
        }
        
        return ITEMS_VC[nextIndex]
    }
}
    
extension TmdbRootViewController: TmdbListViewControllerDelegate, TmdbTvShowViewControllerDelegate {
    func didActive(viewController: UIViewController) {
        tabSegmented.addCurrentIndex(index: viewController.view.tag)
        currentIndex = viewController.view.tag
    }
}

extension TmdbRootViewController: TabSegmentedControlDelegate {
    func changeViewWithIndex(index: Int) {
        guard index != currentIndex else {
            return
        }
        
        var direction: UIPageViewController.NavigationDirection = .forward
        
        if index < currentIndex {
            direction = .reverse
        }
        
        setViewControllers([ITEMS_VC[index]], direction: direction, animated: true, completion: nil)
        
    }
}
