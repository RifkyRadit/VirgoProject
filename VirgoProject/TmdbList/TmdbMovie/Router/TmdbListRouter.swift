//
//  TmdbListRouter.swift
//  VirgoProject
//
//  Created by Administrator on 23/05/22.
//

import UIKit

class TmdbListRouter: PresenterToRouterListProtocol {
    
    static func createModule() -> UIViewController {
        let viewController = TmdbListViewController()
        
        let presenter: ViewToPresenterListProtocol & InteractorToPresenterListProtocol = TmdbListPresenter()

        viewController.presenter = presenter
        viewController.presenter?.view = viewController
        viewController.presenter?.router = TmdbListRouter()
        viewController.presenter?.interactor = TmdbListInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        viewController.navigationController?.navigationItem.title = "TMDB"
        
        return viewController
    }

    func navigateToDetail(on viewController: TmdbListViewController, stateMovie: StateListMovies) {
        
        var titleMovie: String = ""
        
        switch stateMovie {
        case .trendingMovies(let trendingData):
            guard let `trendingData` = trendingData else {
                return
            }
            
            titleMovie = trendingData.title
            
        case .discoverMovies(let discoverData):
            guard let `discoverData` = discoverData else {
                return
            }

            titleMovie = discoverData.title
        }
        
        DispatchQueue.main.async {
            let detailViewController = TmdbDetailRouter.createDetailController(stateMovies: stateMovie)
            let backItem = UIBarButtonItem()
            backItem.title = titleMovie
            viewController.navigationController?.navigationBar.topItem?.backBarButtonItem = backItem
            viewController.navigationController?.pushViewController(detailViewController, animated: false)
        }
    }
}
