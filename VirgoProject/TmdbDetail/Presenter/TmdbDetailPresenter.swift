//
//  TmdbDetailPresenter.swift
//  VirgoProject
//
//  Created by Administrator on 24/05/22.
//

import Foundation

class TmdbDetailPresenter: ViewToPresenterDetailProtocol {
    
    var view: PresenterToViewDetailProtocol?
    var interactor: PresenterToInteractorDetailProtocol?
    var router: PresenterToRouterDetailProtocol?
    
    var itemData: MovieDetailEntity?
    
    func viewDidLoad() {
        interactor?.fetchDetailMovies()
        interactor?.fetchReview()
    }
    
}

extension TmdbDetailPresenter: InteractorToPresenterDetailProtocol {
    
    func fetchDetailMovieSuccess(dataDetail: MovieDetailEntity) {
        DispatchQueue.main.async {
            self.itemData = dataDetail
            self.view?.onFetchSuccess(withData: dataDetail)
        }
    }
    
    func fetchReviewEmpty() {
        DispatchQueue.main.async {
            self.view?.onFetchReviewIsEmpty()
        }
    }
    
    func fetchFailed() {
        DispatchQueue.main.async {
            self.view?.onFetchFailed()
        }
    }
}
