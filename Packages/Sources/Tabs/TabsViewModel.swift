//
//  File.swift
//  
//
//  Created by AmrFawaz on 05/07/2024.
//

import Foundation
import MoviesList

public final class TabsViewModel: ObservableObject {
    @Published var popularMoviesViewModel: PopularMoviesViewModel
    @Published var nowPlayingMoviesViewModel: NowPlayingMoviesViewModel
    @Published var upcomingMoviesViewModel: UpcomingMoviesViewModel

    private let fetchMoviesUseCase: FetchMoviesUseCase

    public init(fetchMoviesUseCase: FetchMoviesUseCase) {
        self.fetchMoviesUseCase = fetchMoviesUseCase
        self.popularMoviesViewModel = PopularMoviesViewModel(
            category: .popular,
            fetchMoviesUseCase: fetchMoviesUseCase
        )
        self.nowPlayingMoviesViewModel = NowPlayingMoviesViewModel(
            category: .nowPlaying,
            fetchMoviesUseCase: fetchMoviesUseCase
        )
        self.upcomingMoviesViewModel = UpcomingMoviesViewModel(
            category: .upcoming,
            fetchMoviesUseCase: fetchMoviesUseCase
        )
    }
}
