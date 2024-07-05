//
//  PopularMoviesViewModel.swift
//
//
//  Created by AmrFawaz on 04/07/2024.
//

import Foundation
import Combine

public final class PopularMoviesViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var errorMessage: String = ""

    var currentPage: Int = 0
    var totalPages: Int = 0
    var isLoading: Bool = false

    private let fetchMoviesUseCase: FetchMoviesUseCase
    private var cancellables = Set<AnyCancellable>()

    public init(fetchMoviesUseCase: FetchMoviesUseCase) {
        self.fetchMoviesUseCase = fetchMoviesUseCase
    }

    func fetchMovies(refreshMovies: Bool = false) {
        if refreshMovies {
            resetMovies()
        }

        guard currentPage <= totalPages && !isLoading else { return }
        isLoading = true

        Task {
            do {
                let response = try await fetchMoviesUseCase.execute(page: currentPage + 1)
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
}

private extension PopularMoviesViewModel {
    func resetMovies() {
        self.movies = []
        self.currentPage = 0
        self.totalPages = 0
        self.isLoading = false
    }
}
