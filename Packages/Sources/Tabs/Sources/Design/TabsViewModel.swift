//
//  TabsViewModel.swift
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
        self.popularMoviesViewModel = Container.getPopularMoviesViewModel(fetchMoviesUseCase: fetchMoviesUseCase)
        self.nowPlayingMoviesViewModel = Container.getNowPlayingMoviesViewModel(fetchMoviesUseCase: fetchMoviesUseCase)
        self.upcomingMoviesViewModel = Container.getUpcomingMoviesViewModel(fetchMoviesUseCase: fetchMoviesUseCase)
    }
}
