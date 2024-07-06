//
//  MovieDetailsRepository.swift
//  
//
//  Created by AmrFawaz on 06/07/2024.
//

import Foundation

public protocol MovieDetailsRepository {
    func fetchMovieDetails(movieID: Int) async throws -> MovieDetails
}
