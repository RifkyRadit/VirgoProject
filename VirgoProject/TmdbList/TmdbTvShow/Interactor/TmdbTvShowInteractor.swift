//
//  TmdbTvShowInteractor.swift
//  VirgoProject
//
//  Created by Administrator on 24/05/22.
//

import Foundation

class TmdbTvShowInteractor: PresenterToInteractorTvShowProtocol {
    
    var presenter: InteractorToPresenterTvShowProtocol?
    
    func fetchTvShow(pageNumber: Int, isLoadMore: Bool) {
        let urlRequest = [NetworkHelper.shared.urlPathTvShow, NetworkHelper.shared.queryStringTvShow(pageNumber: pageNumber)].joined()
        
        guard let url = URL(string: urlRequest) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else {
                self.presenter?.fetchedFailed()
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let response = try jsonDecoder.decode(TvShowEntity.self, from: data)
                
                guard let responseData = response.results, !responseData.isEmpty else {
                    self.presenter?.fetchedFailed()
                    return
                }
                
                if !isLoadMore {
                    self.presenter?.fetchedTvShowSuccess(data: responseData)
                } else {
                    self.presenter?.fetchLoadMoreSuccess(data: responseData)
                }
                
            } catch {
                self.presenter?.fetchedFailed()
            }
            
        }.resume()
    }
}
