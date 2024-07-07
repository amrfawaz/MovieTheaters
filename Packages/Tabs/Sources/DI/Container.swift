//
//  Container.swift
//
//
//  Created by AmrFawaz on 07/07/2024.
//

import Foundation
import MoviesList
final class Container {
    static func getPopularMoviesViewModel(fetchMoviesUseCase: FetchMoviesUseCase) -> PopularMoviesViewModel {
        PopularMoviesViewModel(
            category: .popular,
            fetchMoviesUseCase: fetchMoviesUseCase
        )
    }
    
    static func getNowPlayingMoviesViewModel(fetchMoviesUseCase: FetchMoviesUseCase) -> NowPlayingMoviesViewModel {
        NowPlayingMoviesViewModel(
            category: .nowPlaying,
            fetchMoviesUseCase: fetchMoviesUseCase
        )
    }
    
    static func getUpcomingMoviesViewModel(fetchMoviesUseCase: FetchMoviesUseCase) -> UpcomingMoviesViewModel {
        UpcomingMoviesViewModel(
            category: .nowPlaying,
            fetchMoviesUseCase: fetchMoviesUseCase
        )
    }
}
