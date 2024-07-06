//
//  banquemisr_challenge05App.swift
//  banquemisr.challenge05
//
//  Created by AmrFawaz on 04/07/2024.
//

import SwiftUI
import Tabs
import MoviesList

@main
struct banquemisr_challenge05App: App {
    var body: some Scene {
        WindowGroup {
            let moviesRepository = MovieRepositoryImpl(api: MovieAPI())
            let fetchMoviesUseCase = FetchMoviesUseCase(repository: moviesRepository)

            TabsView(viewModel: TabsViewModel(fetchMoviesUseCase: fetchMoviesUseCase))
        }
    }
}
