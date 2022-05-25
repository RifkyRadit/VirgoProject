//
//  TmdbListProtocol.swift
//  VirgoProject
//
//  Created by Administrator on 23/05/22.
//

import Foundation
import UIKit

protocol ViewToPresenterListProtocol: AnyObject {
    var view: PresenterToViewListProtocol? { get set }
    var interactor: PresenterToInteractorListProtocol? { get set }
    var router: PresenterToRouterListProtocol? { get set }
    
    var listTrendingMovies: [MoviesResult]? { get set }
    var listDiscoverMovies: [DiscoverMovieResult]? { get set }
    var stateMovies: StateListMovies? { get set }
    
    func viewDidLoad()
    
    func didSelectRowAt(index: Int, stateMovies: StateListMovies)
}

protocol PresenterToViewListProtocol: AnyObject {
    func onFetchTrendingSuccess(moviesData: [MoviesResult])
    func onFetchDiscoverSuccess(moviesData: [DiscoverMovieResult])
    func onFetchFailure()
}

protocol PresenterToInteractorListProtocol: AnyObject {
    var presenter: InteractorToPresenterListProtocol? { get set }
    
    func fetchTrandingMovie()
    func fetchDiscoverMovie()
}

protocol InteractorToPresenterListProtocol: AnyObject {
    func fetchedMovieSuccess(moviesData: [MoviesResult])
    func fetchedDiscoverMovieSuccess(discoverData: [DiscoverMovieResult])
    func fetchedFailed()
}

protocol PresenterToRouterListProtocol: AnyObject {
    static func createModule() -> UIViewController
    func navigateToDetail(on viewController: TmdbListViewController, stateMovie: StateListMovies)
}
