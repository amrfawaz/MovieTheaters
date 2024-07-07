//
//  DefaultFetchMovieDetailsUseCaseTests.swift
//
//
//  Created by AmrFawaz on 07/07/2024.
//

import XCTest

@testable import Networking
@testable import MovieDetails

final class DefaultFetchMovieDetailsUseCaseTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testExecuteSuccess() async throws {
        // given
        let mockNetworkManager = MockNetworkManager()
        let movieDetails = MovieDetails.mockedMovieDetails
        let data = try JSONEncoder().encode(movieDetails)
        mockNetworkManager.responseData = data

        // when
        let api = MovieDetailsAPI(networkManager: mockNetworkManager)
        let repository = MovieDetailsRepositoryImpl(api: api)
        let useCase = DefaultFetchMovieDetailsUseCase(repository: repository)
        let fetchResult = try await useCase.execute(movieID: 1)

        // then
        XCTAssertEqual(fetchResult.title, "Kingdom of the Planet of the Apes")
    }

    func testExecuteFailure() async throws {
        // given
        let mockNetworkManager = MockNetworkManager()
        mockNetworkManager.responseError = .serverError

        // when
        let api = MovieDetailsAPI(networkManager: mockNetworkManager)
        let repository = MovieDetailsRepositoryImpl(api: api)
        let useCase = DefaultFetchMovieDetailsUseCase(repository: repository)

        // then
        do {
            _ = try await useCase.execute(movieID: 1)
            XCTFail("Expected to throw an error")
        } catch {
            XCTAssertEqual(error as? NetworkError, NetworkError.serverError)
        }
    }
}
