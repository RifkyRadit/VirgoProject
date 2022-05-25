//
//  TmdbListInteractor.swift
//  VirgoProject
//
//  Created by Administrator on 23/05/22.
//

import Foundation

class TmdbListInteractor: PresenterToInteractorListProtocol {
    var presenter: InteractorToPresenterListProtocol?
    
    func fetchTrandingMovie() {
        let urlString = [NetworkHelper.shared.urlPathTrandingMovie, NetworkHelper.shared.queryString.convertQueryString].joined()
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else {
                self.presenter?.fetchedFailed()
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let response = try jsonDecoder.decode(Movies.self, from: data)
                
                guard !response.results.isEmpty else {
                    self.presenter?.fetchedFailed()
                    return
                }
                
                self.presenter?.fetchedMovieSuccess(moviesData: response.results)
                
            } catch {
                self.presenter?.fetchedFailed()
            }
            
        }.resume()
    }
    
    func fetchDiscoverMovie() {
        let urlString = [NetworkHelper.shared.urlPathDiscoverMovie, NetworkHelper.shared.queryStringDiscoverMovie()].joined()
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else {
                return
            }

            let jsonDecoder = JSONDecoder()
            do {
                let response = try jsonDecoder.decode(DiscoverMovie.self, from: data)
                
                guard !response.results.isEmpty else {
                    self.presenter?.fetchedFailed()
                    return
                }
                
                self.presenter?.fetchedDiscoverMovieSuccess(discoverData: response.results)
            } catch {
                self.presenter?.fetchedFailed()
            }
            
        }.resume()
    }
}
