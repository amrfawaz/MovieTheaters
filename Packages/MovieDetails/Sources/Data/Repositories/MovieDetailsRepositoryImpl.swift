//
//  MovieDetailsRepository.swift
//  
//
//  Created by AmrFawaz on 06/07/2024.
//

import Foundation

public final class MovieDetailsRepositoryImpl: MovieDetailsRepository {
    private let api: MovieDetailsAPI

    public init(api: MovieDetailsAPI) {
        self.api = api
    }

    public func fetchMovieDetails(movieID: Int) async throws -> MovieDetails {
        return try await api.fetchMovieDetails(movieID: movieID)
    }
}
