//
//  TmdbListPresenter.swift
//  VirgoProject
//
//  Created by Administrator on 23/05/22.
//

import Foundation

class TmdbListPresenter: ViewToPresenterListProtocol {
    
    var view: PresenterToViewListProtocol?
    var interactor: PresenterToInteractorListProtocol?
    var router: PresenterToRouterListProtocol?
    
    var listTrendingMovies: [MoviesResult]?
    var listDiscoverMovies: [DiscoverMovieResult]?
    var stateMovies: StateListMovies?
    
    func viewDidLoad() {
        interactor?.fetchTrandingMovie()
        interactor?.fetchDiscoverMovie()
    }
    
    func numberOfItemsInSection() -> Int {
        return 0
    }
    
    func urlStringImagePoster(indexPath: IndexPath) -> String? {
        return nil
    }
    
    func didSelectRowAt(index: Int, stateMovies: StateListMovies) {
        guard let view = self.view, let viewController = view as? TmdbListViewController else {
            return
        }
        
        switch stateMovies {
        case .trendingMovies:
            guard let listTrendingMovies = listTrendingMovies else {
                return
            }

            let itemData = listTrendingMovies[index]
            self.router?.navigateToDetail(on: viewController, stateMovie: .trendingMovies(itemData))
            
        case .discoverMovies:
            guard let listDiscoverMovies = listDiscoverMovies else {
                return
            }

            let itemData = listDiscoverMovies[index]
            self.router?.navigateToDetail(on: viewController, stateMovie: .discoverMovies(itemData))
            
        default:
            break
        }
    }
}

extension TmdbListPresenter: InteractorToPresenterListProtocol {
    func fetchedMovieSuccess(moviesData: [MoviesResult]) {
        DispatchQueue.main.async {
            self.listTrendingMovies = moviesData
            self.view?.onFetchTrendingSuccess(moviesData: moviesData)
        }
    }
    
    func fetchedDiscoverMovieSuccess(discoverData: [DiscoverMovieResult]) {
        DispatchQueue.main.async {
            self.listDiscoverMovies = discoverData
            self.view?.onFetchDiscoverSuccess(moviesData: discoverData)
        }
    }
    
    func fetchedFailed() {
        view?.onFetchFailure()
    }
}
