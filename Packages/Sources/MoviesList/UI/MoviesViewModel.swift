//
//  MoviesViewModel.swift
//
//
//  Created by AmrFawaz on 04/07/2024.
//

import Foundation
import Combine

public class MoviesViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var errorMessage: String = ""

    public var pageTitle: String {
        ""
    }

    var currentPage: Int = 0
    var totalPages: Int = 0
    var isLoading: Bool = false

    private let fetchMoviesUseCase: FetchMoviesUseCase

    public init(
        fetchMoviesUseCase: FetchMoviesUseCase
    ) {
        self.fetchMoviesUseCase = fetchMoviesUseCase
    }

    final func fetchMovies(refreshMovies: Bool = false) {
        if refreshMovies {
            resetMovies()
        }

        guard currentPage <= totalPages && !isLoading else { return }
        isLoading = true

        Task {
            do {
                let response = try await fetchMoviesUseCase.execute(request: createRequest(), page: currentPage + 1)
                DispatchQueue.main.async {
                    self.movies.append(contentsOf: response.movies)
                    self.currentPage = response.page
                    self.totalPages = response.totalPages
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                }
            }
        }
    }

    final func resetMovies() {
        self.movies = []
        self.currentPage = 0
        self.totalPages = 0
        self.isLoading = false
    }

    func createRequest() -> FetchMoviesRequest {
        FetchPopularMoviesRequest()
    }
}
