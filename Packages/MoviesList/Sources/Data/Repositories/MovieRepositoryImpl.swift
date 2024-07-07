//
//  MovieRepositoryImpl.swift
//
//
//  Created by AmrFawaz on 04/07/2024.
//

import Foundation
import Networking

public class MovieRepositoryImpl: MovieRepository {
    private let api: MovieAPI

    public init(api: MovieAPI) {
        self.api = api
    }

    public func fetchMovies<T: FetchMoviesRequest>(request: T) async throws -> FetchMoviesResponse {
        return try await api.fetchMovies(request: request)
    }
}

// MARK: - Mocks
#if DEBUG
final class MockMovieRepository: MovieRepository {
    var result: Result<FetchMoviesResponse, Error>?
    
    func fetchMovies<T>(request: T) async throws -> FetchMoviesResponse where T : FetchMoviesRequest {
        print("Mock fetchMovies called with request: \(request)")
        switch result {
        case .success(let response)?:
            return response
        case .failure(let error)?:
            throw error
        case .none:
            fatalError("Mock result not set")
        }
    }
}
#endif
