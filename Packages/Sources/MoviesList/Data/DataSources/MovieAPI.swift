//
//  MovieAPI.swift
//
//
//  Created by AmrFawaz on 04/07/2024.
//

import Foundation
import AppConfigurations
import Networking

public protocol MovieAPIProtocol {
    func fetchMovies(request: FetchMoviesRequest) async throws -> FetchMoviesResponse
}

public class MovieAPI: MovieAPIProtocol {
    private let urlSession = URLSession.shared
    private lazy var response = FetchMoviesResponse(
        page: 0,
        movies: [],
        totalPages: 0
    )

    public init() {}

    public func fetchMovies(request: FetchMoviesRequest) async throws -> FetchMoviesResponse {
        guard let url = request.request?.url else { throw NetworkError.invalidURL }

        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = request.params.map { URLQueryItem(name: $0.key, value: $0.value) }

        guard let request = request.request else { throw NetworkError.invalidRequest }

        let network = NetworkManager()

        do {
            return try await network.request(request: request, of: FetchMoviesResponse.self)
        } catch {
            throw error
        }
    }
}
