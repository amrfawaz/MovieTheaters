//
//  PopularMoviesView.swift
//
//
//  Created by AmrFawaz on 05/07/2024.
//

import SwiftUI
import CoreInterface
import MovieDetails

public struct PopularMoviesView: View {
    @ObservedObject private var viewModel: PopularMoviesViewModel

    @State private var path = NavigationPath()

    public init(viewModel: PopularMoviesViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        NavigationStack(path: $path) {
            content
                .padding(.vertical, Style.Spacing.md)
                .onFirstAppear {
                    viewModel.fetchMovies()
                }
                .alert(isPresented: Binding<Bool>(
                    get: { !viewModel.errorMessage.isEmpty },
                    set: { newValue in
                        if !newValue {
                            viewModel.errorMessage = ""
                        }
                    }
                )) {
                    Alert(
                        title: Text("Error"),
                        message: Text(viewModel.errorMessage),
                        dismissButton: .default(Text("OK"))
                    )
                }
        }
    }
}

private extension PopularMoviesView {
    private var content: some View {
        ScrollView {
            VStack(spacing: Style.Spacing.md) {
                title
                list
            }
        }
        .refreshable {
            viewModel.fetchMovies(refreshMovies: true)
        }
    }

    var title: some View {
        Text(viewModel.pageTitle)
            .typography(.heading01)
            .foregroundStyle(.black)
    }

    private var list: some View {
        LazyVStack {
            ForEach(viewModel.movies) { movie in
                let movieViewModel = MovieViewModel(movie: movie)

                MovieView(viewModel: movieViewModel)
                    .onAppear {
                        // Trigger pagination when the last movie appears
                        if movie.id == viewModel.movies.last?.id {
                            Task {
                                viewModel.fetchMovies()
                            }
                        }
                    }
                    .onReceive(movieViewModel.subject) { action in
                        handleMovieViewAction(action, movie: movie)
                    }
            }
        }
        .navigationDestination(for: Movie.self) { movie in
            MovieDetailsView(
                viewModel: MovieDetailsViewModel(movieID: movie.id),
                path: $path
            )
        }
    }

    private func handleMovieViewAction(
        _ action: MovieViewAction,
        movie: Movie
    ) {
        switch action {
        case .didTapMovieCard:
            path.append(movie)
        }
    }
}
