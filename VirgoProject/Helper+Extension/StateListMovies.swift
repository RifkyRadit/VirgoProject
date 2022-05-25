//
//  StateListMovies.swift
//  VirgoProject
//
//  Created by Administrator on 24/05/22.
//

import Foundation

enum StateListMovies {
    case trendingMovies(_ itemData: MoviesResult? = nil)
    case discoverMovies(_ itemData: DiscoverMovieResult? = nil)
}
