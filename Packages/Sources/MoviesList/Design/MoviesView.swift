//
//  MoviesView.swift
//
//
//  Created by AmrFawaz on 06/07/2024.
//

import SwiftUI
import CoreInterface
import MovieDetails

public struct MoviesView<ViewModel: MoviesViewModel>: View {
    @ObservedObject private var viewModel: ViewModel
    @State private var path = NavigationPath()

    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        NavigationStack(path: $path) {
            content
                .padding(.vertical, Style.Spacing.md)
                .onFirstAppear {
                    await viewModel.fetchMovies()
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

    private var content: some View {
        ScrollView {
            if viewModel.isLoading {
                ProgressView()
            }
            VStack(spacing: Style.Spacing.md) {
                title
                list
            }
        }
        .refreshable {
            await viewModel.fetchMovies(refreshMovies: true)
        }
    }

    private var title: some View {
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
                                await viewModel.fetchMovies()
                            }
                        }
                    }
                    .onReceive(movieViewModel.subject) { action in
                        handleMovieViewAction(action, movie: movie)
                    }
            }
        }
        .navigationDestination(for: Movie.self) { movie in
            let viewModel = MovieDetailsViewModel(movieID: movie.id, fetchMovieDetailsUseCase: viewModel.fetchMovieDetailsUseCase)
            MovieDetailsView(viewModel: viewModel, path: $path)
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
