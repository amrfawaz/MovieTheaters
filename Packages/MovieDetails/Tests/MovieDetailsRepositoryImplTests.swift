//
//  MovieDetailsRepositoryImplTests.swift
//
//
//  Created by AmrFawaz on 07/07/2024.
//

import XCTest

@testable import Networking
@testable import MovieDetails

final class MovieDetailsRepositoryImplTests: XCTestCase {
    var movieDetailsAPI: MovieDetailsAPI!
    var mockNetworkManager: MockNetworkManager!

    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        movieDetailsAPI = MovieDetailsAPI(networkManager: mockNetworkManager)
    }

    override func tearDown() {
        super.tearDown()
        movieDetailsAPI = MovieDetailsAPI(networkManager: mockNetworkManager)
        mockNetworkManager = MockNetworkManager()
    }

    func testFetchMovieDetailsSuccess() async throws {
        // given
        let movieDetails = MovieDetails.mockedMovieDetails
        let data = try JSONEncoder().encode(movieDetails)
        mockNetworkManager.responseData = data

        // when
        let repository = MovieDetailsRepositoryImpl(api: movieDetailsAPI)
        let fetchResult = try await repository.fetchMovieDetails(movieID: 1)

        // then
        XCTAssertEqual(fetchResult.title, "Kingdom of the Planet of the Apes")
    }

    func testFetchMovieDetailsFailure() async throws {
        // given
        mockNetworkManager.responseError = .serverError

        // then
        let repository = MovieDetailsRepositoryImpl(api: movieDetailsAPI)
        do {
            _ = try await repository.fetchMovieDetails(movieID: 1)
            XCTFail("Expected to throw an error")
        } catch {
            XCTAssertEqual(error as? NetworkError, NetworkError.serverError)
        }
    }
}
