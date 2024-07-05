//
//  PopularMoviesListView.swift
//
//
//  Created by AmrFawaz on 04/07/2024.
//

import Combine
import CoreInterface
import MovieDetails
import SwiftUI

public struct PopularMoviesListView: View {
    private enum Constants {
        static let pageTitle = "Explore Popular Movies"
        static let errorTitle = "Error"
    }

    @StateObject private var viewModel: PopularMoviesViewModel

    @State private var path = NavigationPath()
    @State private var cancellables = Set<AnyCancellable>()
    @State private var showAlert = false

    public init(viewModel: PopularMoviesViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    public var body: some View {
        NavigationStack(path: $path) {
            TabView {
                popularMovies
                    .tabItem {
                        Image(systemName: "play.circle")
                        Text("Now Playing")
                    }

                popularMovies
                    .tabItem {
                        Image(systemName: "film")
                        Text("Popular")
                    }

                popularMovies
                    .tabItem {
                        Image(systemName: "calendar.circle")
                        Text("Section 3")
                    }
            }
        }
    }
}

private extension PopularMoviesListView {
    private var popularMovies: some View {
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

private extension PopularMoviesListView {
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
        Text(Constants.pageTitle)
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

//#Preview {
//    PopularMoviesListView()
//}
