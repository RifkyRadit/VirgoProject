//
//  TmdbDetailInteractor.swift
//  VirgoProject
//
//  Created by Administrator on 24/05/22.
//

import UIKit

class TmdbDetailInteractor: PresenterToInteractorDetailProtocol {
    
    var presenter: InteractorToPresenterDetailProtocol?
    var dataStateMovie: StateListMovies?
    
    func fetchDetailMovies() {
        
        guard getMovieId() != 0 else {
            return
        }
        
        let urlMovieDetail = NetworkHelper.shared.getBaseUrlMovieDetail(movieId: getMovieId())
        let urlRequest = [urlMovieDetail, NetworkHelper.shared.queryStringMovieDetail()].joined()
        
        guard let url = URL(string: urlRequest) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else {
                self.presenter?.fetchFailed()
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let response = try jsonDecoder.decode(MovieDetailEntity.self, from: data)

                self.presenter?.fetchDetailMovieSuccess(dataDetail: response)
                
            } catch  {
                self.presenter?.fetchFailed()
                
            }
            
        }.resume()
        
    }
    
    func fetchReview() {
        let url = "https://api.themoviedb.org/3/review/\(getMovieId())?api_key=13c8c544f618ba1e9ccbdca6c6066f84"
        
        guard let url = URL(string: url) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
                
            guard let data = data else {
                self.presenter?.fetchFailed()
                return
            }

            let jsonDecoder = JSONDecoder()
            if let _ = try? jsonDecoder.decode(DefaultEntity.self, from: data) {
                self.presenter?.fetchReviewEmpty()
            }
            
        }.resume()
    }
    
    func getMovieId() -> Int {
        guard let dataStateMovie = dataStateMovie else {
            return 0
        }

        switch dataStateMovie {
        case .trendingMovies(let itemTrending):
            guard let itemTrending = itemTrending else {
                return 0
            }

            return itemTrending.id
            
        case .discoverMovies(let itemDiscover):
            guard let itemDiscover = itemDiscover else {
                return 0
            }

            return itemDiscover.id
        }
    }
}
