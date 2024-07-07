//
//  MovieAPITests.swift
//
//
//  Created by AmrFawaz on 07/07/2024.
//

import XCTest

@testable import Networking
@testable import MoviesList

final class MovieAPITests: XCTestCase {
    var movieAPI: MovieAPI!
    var mockNetworkManager: MockNetworkManager!

    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        movieAPI = MovieAPI(networkManager: mockNetworkManager)
    }

    override func tearDown() {
        movieAPI = nil
        mockNetworkManager = nil
        super.tearDown()
    }

    func testFetchMoviesSuccess() async throws {
        // given
        let mockedMovies = Movie.mockedMovies
        let mockResponse = FetchMoviesResponse(page: 1, movies: mockedMovies, totalPages: mockedMovies.count)
        let responseData = try JSONEncoder().encode(mockResponse)
        mockNetworkManager.responseData = responseData

        // when
        let request = FetchPopularMoviesRequest()
        let response = try await movieAPI.fetchMovies(request: request)

        // then
        XCTAssertEqual(response.page, 1)
        XCTAssertEqual(response.movies.count, 6)
        XCTAssertEqual(response.movies.first?.originalTitle, "Kingdom of the Planet of the Apes")
    }

    func testFetchMoviesFailure() async throws {
        // given
        mockNetworkManager.responseError = NetworkError.serverError

        let request = FetchPopularMoviesRequest()

        // then
        do {
            _ = try await movieAPI.fetchMovies(request: request)
            XCTFail("Expected to throw NetworkError.serverError")
        } catch {
            XCTAssertEqual(error as? NetworkError, NetworkError.serverError)
        }
    }
}
