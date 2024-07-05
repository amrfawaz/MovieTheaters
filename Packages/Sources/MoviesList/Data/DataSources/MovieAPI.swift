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
    func fetchMovies(page: Int) async throws -> FetchPopularMoviesResponse
}

public class MovieAPI: MovieAPIProtocol {
    private let urlSession = URLSession.shared
    private lazy var response = FetchPopularMoviesResponse(
        page: 0,
        movies: [],
        totalPages: 0
    )

    public init() {}

    public func fetchMovies(page: Int) async throws -> FetchPopularMoviesResponse {
        var fetchPopularMoviesRequest = FetchPopularMoviesRequest()
        guard let url = fetchPopularMoviesRequest.request?.url else { throw NetworkError.invalidURL }

        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        fetchPopularMoviesRequest.params["page"] = "\(page)"
        components?.queryItems = fetchPopularMoviesRequest.params.map { URLQueryItem(name: $0.key, value: $0.value) }

        guard let request = fetchPopularMoviesRequest.request else { throw NetworkError.invalidRequest }

        let network = NetworkManager()

        do {
            return try await network.request(request: request, of: FetchPopularMoviesResponse.self)
        } catch {
            throw error
        }
    }
}
