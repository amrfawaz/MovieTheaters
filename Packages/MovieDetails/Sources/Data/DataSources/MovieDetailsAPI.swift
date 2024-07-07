//
//  MovieDetailsAPI.swift
//  
//
//  Created by AmrFawaz on 06/07/2024.
//

import Foundation
import Networking

protocol MovieDetailsAPIProtocol {
    func fetchMovieDetails(movieID: Int) async throws -> MovieDetails
}

public final class MovieDetailsAPI: MovieDetailsAPIProtocol {
    private let networkManager: NetworkManager

    public init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }

    public func fetchMovieDetails(movieID: Int) async throws -> MovieDetails {
        let request = MovieDetailsRequest(movieID: movieID)

        guard let urlRequest = request.request else {
            throw NetworkError.invalidRequest
        }

        do {
            return try await networkManager.request(request: urlRequest, of: MovieDetails.self)
        } catch {
            throw error
        }
    }
}
