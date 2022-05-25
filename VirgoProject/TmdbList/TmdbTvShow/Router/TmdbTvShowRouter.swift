//
//  TmdbTvShowRouter.swift
//  VirgoProject
//
//  Created by Administrator on 24/05/22.
//

import UIKit

class TmdbTvShowRouter: PresenterToRouterTvShowProtocol {
    static func createModule() -> UIViewController {
        let viewController = TmdbTvShowViewController()
        
        let presenter: ViewToPresenterTvShowProtocol & InteractorToPresenterTvShowProtocol = TmdbTvShowPresenter()

        viewController.presenter = presenter
        viewController.presenter?.view = viewController
        viewController.presenter?.router = TmdbTvShowRouter()
        viewController.presenter?.interactor = TmdbTvShowInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
}
