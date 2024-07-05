//
//  banquemisr_challenge05App.swift
//  banquemisr.challenge05
//
//  Created by AmrFawaz on 04/07/2024.
//

import SwiftUI
import MoviesList

@main
struct banquemisr_challenge05App: App {
    var body: some Scene {
        WindowGroup {
            let moviesRepository = MovieRepositoryImpl(api: MovieAPI())
            let fetchMoviesUseCase = FetchMoviesUseCase(repository: moviesRepository)
            let moviesListViewModel = PopularMoviesViewModel(fetchMoviesUseCase: fetchMoviesUseCase)

            PopularMoviesListView(viewModel: moviesListViewModel)
        }
    }
}
