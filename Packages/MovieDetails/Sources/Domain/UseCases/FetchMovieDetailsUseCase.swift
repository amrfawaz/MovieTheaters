//
//  FetchMovieDetailsUseCase.swift
//
//
//  Created by AmrFawaz on 06/07/2024.
//

import Foundation

public protocol FetchMovieDetailsUseCase {
    func execute(movieID: Int) async throws -> MovieDetails
}

public final class DefaultFetchMovieDetailsUseCase: FetchMovieDetailsUseCase {
    private let repository: MovieDetailsRepository

    public init(repository: MovieDetailsRepository) {
        self.repository = repository
    }

    public func execute(movieID: Int) async throws -> MovieDetails {
        return try await repository.fetchMovieDetails(movieID: movieID)
    }
}
