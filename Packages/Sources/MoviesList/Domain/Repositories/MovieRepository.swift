//
//  MovieRepository.swift
//
//
//  Created by AmrFawaz on 04/07/2024.
//

import Foundation

public protocol MovieRepository {
    func fetchMovies<T: FetchMoviesRequest>(request: T) async throws -> FetchPopularMoviesResponse
}
