//
//  TmdbTvShowProtocol.swift
//  VirgoProject
//
//  Created by Administrator on 24/05/22.
//

import Foundation
import UIKit

protocol ViewToPresenterTvShowProtocol: AnyObject {
    var view: PresenterToViewTvShowProtocol? { get set }
    var interactor: PresenterToInteractorTvShowProtocol? { get set }
    var router: PresenterToRouterTvShowProtocol? { get set }
    
    var tvShowItems: [TvShowEntityResult]? { get set }
    
    func viewDidLoad()
    func loadMoreTvShow(pageNumber: Int)
    
    func numberOfItemsInSection() -> Int
    func listTvShowPoster(indexPath: IndexPath) -> String?
}

protocol PresenterToViewTvShowProtocol: AnyObject {
    func onFetchSuccess()
    func onFetchFailure()
}

protocol PresenterToInteractorTvShowProtocol: AnyObject {
    var presenter: InteractorToPresenterTvShowProtocol? { get set }
    
    func fetchTvShow(pageNumber: Int, isLoadMore: Bool)
}

protocol InteractorToPresenterTvShowProtocol: AnyObject {
    func fetchedTvShowSuccess(data: [TvShowEntityResult])
    func fetchLoadMoreSuccess(data: [TvShowEntityResult])
    func fetchedFailed()
}

protocol PresenterToRouterTvShowProtocol: AnyObject {
    static func createModule() -> UIViewController
}
