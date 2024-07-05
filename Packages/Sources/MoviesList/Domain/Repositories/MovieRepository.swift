//
//  MovieRepository.swift
//
//
//  Created by AmrFawaz on 04/07/2024.
//

import Foundation

public protocol MovieRepository {
    func fetchMovies(page: Int) async throws -> FetchPopularMoviesResponse
}
