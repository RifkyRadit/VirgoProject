//
//  TmdbDetailProtocol.swift
//  VirgoProject
//
//  Created by Administrator on 24/05/22.
//

import Foundation
import UIKit

protocol ViewToPresenterDetailProtocol: AnyObject {
    var view: PresenterToViewDetailProtocol? { get set }
    var interactor: PresenterToInteractorDetailProtocol? { get set }
    var router: PresenterToRouterDetailProtocol? { get set }
    
    var itemData: MovieDetailEntity? { get set }
//    var itemList: [PokemonEntityData]? { get set }
    
    func viewDidLoad()
}

protocol PresenterToViewDetailProtocol: AnyObject {
    func onFetchSuccess(withData itemData: MovieDetailEntity)
    func onFetchReviewIsEmpty()
    func onFetchFailed()
}

protocol PresenterToInteractorDetailProtocol: AnyObject {
    var presenter: InteractorToPresenterDetailProtocol? { get set }
    var dataStateMovie: StateListMovies? { get set }
    
    func fetchDetailMovies()
    func fetchReview()
}

protocol InteractorToPresenterDetailProtocol: AnyObject {
    func fetchDetailMovieSuccess(dataDetail: MovieDetailEntity)
    func fetchReviewEmpty()
    func fetchFailed()
}

protocol PresenterToRouterDetailProtocol: AnyObject {
    static func createDetailController(stateMovies: StateListMovies) -> UIViewController
//    func navigateToDetail(on: PokemonDetailViewController, with: PokemonEntityData)
}
