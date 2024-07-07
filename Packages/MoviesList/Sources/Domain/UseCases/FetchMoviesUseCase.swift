//
//  FetchMoviesUseCase.swift
//
//
//  Created by AmrFawaz on 04/07/2024.
//

import Foundation
import Networking

public class FetchMoviesUseCase {
    private let repository: MovieRepository

    public init(repository: MovieRepository) {
        self.repository = repository
    }

    func execute<T: FetchMoviesRequest>(request: T, page: Int) async throws -> FetchMoviesResponse {
        var request = request
        request.params["page"] = "\(page)"
        return try await repository.fetchMovies(request: request)
    }
}

// MARK: - Mocks

#if DEBUG
final class MockFetchMoviesUseCase: FetchMoviesUseCase {
    var responseData: Data?
    var responseError: NetworkError?

    override func execute<T>(request: T, page: Int) async throws -> FetchMoviesResponse where T : FetchMoviesRequest {
        if let error = responseError {
            throw error
        }

        guard let data = responseData else {
            throw NetworkError.noData
        }

        do {
            let decodedResponse = try JSONDecoder().decode(FetchMoviesResponse.self, from: data)
            return decodedResponse
        } catch {
            throw NetworkError.decodingError
        }
    }
}
#endif
