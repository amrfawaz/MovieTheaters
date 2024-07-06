//
//  MovieRepositoryImpl.swift
//
//
//  Created by AmrFawaz on 04/07/2024.
//

import Foundation

public class MovieRepositoryImpl: MovieRepository {
    private let api: MovieAPI

    public init(api: MovieAPI) {
        self.api = api
    }

    public func fetchMovies<T: FetchMoviesRequest>(request: T) async throws -> FetchPopularMoviesResponse {
        return try await api.fetchMovies(request: request)
    }
}
