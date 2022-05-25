//
//  TmdbDetailRouter.swift
//  VirgoProject
//
//  Created by Administrator on 24/05/22.
//

import UIKit

class TmdbDetailRouter: PresenterToRouterDetailProtocol {
    static func createDetailController(stateMovies: StateListMovies) -> UIViewController {
        let viewController = TmdbDetailViewController()
//        let viewController = TestDetailViewController()
        
        let presenter: ViewToPresenterDetailProtocol & InteractorToPresenterDetailProtocol = TmdbDetailPresenter()

        viewController.presenter = presenter
        viewController.presenter?.view = viewController
        viewController.presenter?.router = TmdbDetailRouter()
        viewController.presenter?.interactor = TmdbDetailInteractor()
        viewController.presenter?.interactor?.dataStateMovie = stateMovies
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
}
