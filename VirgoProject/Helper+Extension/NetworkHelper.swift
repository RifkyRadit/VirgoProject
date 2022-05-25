//
//  NetworkHelper.swift
//  VirgoProject
//
//  Created by Administrator on 24/05/22.
//

import Foundation

class NetworkHelper {
    
    static let shared = NetworkHelper()
    
    
    
    lazy var baseUrl: String = {
        return "https://api.themoviedb.org/3/"
    }()
    
    lazy var apiKeyQuery: String = {
        return "api_key=13c8c544f618ba1e9ccbdca6c6066f84"
    }()
    
    lazy var queryString: [String: Any] = {
        return ["api_key": "13c8c544f618ba1e9ccbdca6c6066f84"]
    }()
    
    lazy var accessToken: String = {
       return "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxM2M4YzU0NGY2MThiYTFlOWNjYmRjYTZjNjA2NmY4NCIsInN1YiI6IjYyODdjZjQ3MWYzZTYwMDA1MmU4MDdiNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.kenMJrtDMH4SPdMki6IjTwdn3n1blgCntr8RXlfeypo"
    }()
    
    lazy var urlPathTrandingMovie: String = {
        return [baseUrl, "trending/movie/week"].joined()
    }()
    
    lazy var urlPathDiscoverMovie: String = {
        return [baseUrl, "discover/movie"].joined()
    }()
    
    lazy var urlPathTvShow: String = {
        return [baseUrl, "tv/popular"].joined()
    }()
    
    lazy var baseUrlImage: String = {
        return "https://image.tmdb.org/t/p/w185"
    }()
    
    func getBaseUrlMovieDetail(movieId: Int) -> String {
        
        let pathMovieDetail = "movie/\(String(movieId))"
        return [baseUrl, pathMovieDetail].joined()
    }
    
    func queryStringDiscoverMovie() -> String {
        
        var query = queryString
        query.updateValue("en-US", forKey: "language")
        query.updateValue("popularity.asc", forKey: "sort_by")
        query.updateValue("false", forKey: "include_adult")
        query.updateValue("false", forKey: "include_video")
        query.updateValue("1", forKey: "page")
        query.updateValue("flatrate", forKey: "with_watch_monetization_types")
        
        
        return query.convertQueryString
    }
    
    func queryStringMovieDetail() -> String {
        var query = queryString
        query.updateValue("en-US", forKey: "language")
        query.updateValue("images", forKey: "append_to_response")
        
        return query.convertQueryString
    }
    
    func queryStringTvShow(pageNumber: Int) -> String {
        var query = queryString
        query.updateValue("en-US", forKey: "language")
        query.updateValue(String(pageNumber), forKey: "page")
        
        return query.convertQueryString
    }
}
