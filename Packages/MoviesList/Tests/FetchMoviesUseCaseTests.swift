//
//  FetchMoviesUseCaseTests.swift
//  
//
//  Created by AmrFawaz on 07/07/2024.
//

import XCTest

@testable import Networking
@testable import MoviesList

final class FetchMoviesUseCaseTests: XCTestCase {
    var useCase: FetchMoviesUseCase!
    var mockRepository: MockMovieRepository!

    override func setUp() {
        super.setUp()
        mockRepository = MockMovieRepository()
        useCase = FetchMoviesUseCase(repository: mockRepository)
    }

    override func tearDown() {
        useCase = nil
        mockRepository = nil
        super.tearDown()
    }

    func testExecuteSuccess() async throws {
        // given
        let mockMovies = Movie.mockedMovies
        let mockResponse = FetchMoviesResponse(page: 1, movies: mockMovies, totalPages: 1)
        mockRepository.result = .success(mockResponse)

        // when
        let request = FetchPopularMoviesRequest()
        let response = try await useCase.execute(request: request, page: 1)

        // then
        XCTAssertEqual(response.page, 1)
        XCTAssertEqual(response.movies.count, mockMovies.count)
        XCTAssertEqual(response.movies.first?.originalTitle, "Kingdom of the Planet of the Apes")
    }

    func testExecuteFailure() async throws {
        // given
        mockRepository.result = .failure(NetworkError.serverError)

        let request = FetchPopularMoviesRequest()

        // then
        do {
            _ = try await useCase.execute(request: request, page: 1)
            XCTFail("Expected to throw NetworkError.serverError")
        } catch {
            XCTAssertEqual(error as? NetworkError, NetworkError.serverError)
        }
    }
}
