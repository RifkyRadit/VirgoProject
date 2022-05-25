//
//  TmdbTvShowPresenter.swift
//  VirgoProject
//
//  Created by Administrator on 24/05/22.
//

import Foundation

class TmdbTvShowPresenter: ViewToPresenterTvShowProtocol {
    
    var view: PresenterToViewTvShowProtocol?
    var interactor: PresenterToInteractorTvShowProtocol?
    var router: PresenterToRouterTvShowProtocol?
    
    var tvShowItems: [TvShowEntityResult]?
    
    func viewDidLoad() {
        interactor?.fetchTvShow(pageNumber: 1, isLoadMore: false)
    }
    
    func loadMoreTvShow(pageNumber: Int) {
        interactor?.fetchTvShow(pageNumber: pageNumber, isLoadMore: true)
    }
    
    func numberOfItemsInSection() -> Int {
        guard let tvShowItems = tvShowItems else {
            return 0
        }

        return tvShowItems.count
    }
    
    func listTvShowPoster(indexPath: IndexPath) -> String? {
        
        guard let tvShowItems = tvShowItems else {
            return nil
        }
        
        let urlPoster = [NetworkHelper.shared.baseUrlImage, tvShowItems[indexPath.row].posterPath ?? ""].joined()
        
        return urlPoster
    }
}

extension TmdbTvShowPresenter: InteractorToPresenterTvShowProtocol {
    
    func fetchedTvShowSuccess(data: [TvShowEntityResult]) {
        DispatchQueue.main.async {
            self.tvShowItems = data
            self.view?.onFetchSuccess()
        }
    }
    
    func fetchLoadMoreSuccess(data: [TvShowEntityResult]) {
        DispatchQueue.main.async {
            self.tvShowItems?.append(contentsOf: data)
            self.view?.onFetchSuccess()
        }
    }
    
    func fetchedFailed() {
        DispatchQueue.main.async {
            self.view?.onFetchFailure()
        }
    }
}
