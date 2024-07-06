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

    func execute<T: FetchMoviesRequest>(request: T, page: Int) async throws -> FetchMoviesResponse {
        var request = request
        request.params["page"] = "\(page)"
        return try await repository.fetchMovies(request: request)
    }
}
