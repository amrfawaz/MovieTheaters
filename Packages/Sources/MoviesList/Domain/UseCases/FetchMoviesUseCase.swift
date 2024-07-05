//
//  FetchMoviesUseCase.swift
//
//
//  Created by AmrFawaz on 04/07/2024.
//

import Foundation

public class FetchMoviesUseCase {
    private let repository: MovieRepository

    public init(repository: MovieRepository) {
        self.repository = repository
    }

    func execute(page: Int) async throws -> FetchPopularMoviesResponse {
        return try await repository.fetchMovies(page: page)
    }
}
