//
//  MoviesViewModelTests.swift
//  
//
//  Created by AmrFawaz on 07/07/2024.
//

import XCTest
import Combine

@testable import MoviesList
@testable import Networking

final class MoviesViewModelTests: XCTestCase {
    var viewModel: NowPlayingMoviesViewModel!
    var fetchMoviesUseCase: MockFetchMoviesUseCase!
    var mockRepository: MockMovieRepository!

    override func setUp() {
        super.setUp()
        mockRepository = MockMovieRepository()
        fetchMoviesUseCase = MockFetchMoviesUseCase(repository: mockRepository)
        viewModel = NowPlayingMoviesViewModel(
            category: .nowPlaying,
            fetchMoviesUseCase: fetchMoviesUseCase
        )
    }

    override func tearDown() {
        viewModel = nil
        fetchMoviesUseCase = nil
        mockRepository = nil
        super.tearDown()
    }

    func testInitialization() {
        // given
        let repository = MockMovieRepository()
        let moviesUseCase = MockFetchMoviesUseCase(repository: repository)

        // when
        let viewModel = NowPlayingMoviesViewModel(
            category: .nowPlaying,
            fetchMoviesUseCase: moviesUseCase
        )

        // then
        XCTAssertEqual(viewModel.movies.count, 0)
        XCTAssertEqual(viewModel.errorMessage, "")
        XCTAssertEqual(viewModel.currentPage, 0)
        XCTAssertEqual(viewModel.totalPages, 1)
        XCTAssertFalse(viewModel.isLoading)
    }

    func testFetchMoviesSuccess() async throws {
        // given
        let mockedMovies = Movie.mockedMovies
        let mockResponse = FetchMoviesResponse(page: 1, movies: mockedMovies, totalPages: 1)
        fetchMoviesUseCase.responseData = try JSONEncoder().encode(mockResponse)
        mockRepository.result = .success(mockResponse)
        
        // when
        let expectation = XCTestExpectation(description: "Fetch movies completes")

        Task {
            await viewModel.fetchMovies()
            expectation.fulfill()
        }

        await fulfillment(of: [expectation], timeout: 3)
        
        // then
        XCTAssertEqual(viewModel.movies.count, mockedMovies.count)
        XCTAssertEqual(viewModel.movies.first?.originalTitle, "Kingdom of the Planet of the Apes")
        XCTAssertEqual(viewModel.currentPage, 1)
        XCTAssertEqual(viewModel.totalPages, 1)
        XCTAssertFalse(viewModel.isLoading)
    }


    func testFetchMoviesError() async throws {
        // given
        let mockError = NetworkError.serverError
        fetchMoviesUseCase.responseData = nil
        mockRepository.result = .failure(mockError)

        let expectation = XCTestExpectation(description: "Failed to fetch movies")

        Task {
            await viewModel.fetchMovies()
            expectation.fulfill()
        }

        await fulfillment(of: [expectation], timeout: 3)

        // then
        XCTAssertEqual(viewModel.movies.count, 0)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)
    }

    func testFetchMoviesWithRefresh() async throws {
        // given
        let mockedMovies = Movie.mockedMovies
        let mockResponse = FetchMoviesResponse(page: 1, movies: mockedMovies, totalPages: 1)
        fetchMoviesUseCase.responseData = try JSONEncoder().encode(mockResponse)
        mockRepository.result = .success(mockResponse)

        let expectation = XCTestExpectation(description: "Fetch movies completes")

        Task {
            await viewModel.fetchMovies(refreshMovies: true)
            expectation.fulfill()
        }

        await fulfillment(of: [expectation], timeout: 3)

        // then
        XCTAssertEqual(viewModel.movies.count, mockedMovies.count)
        XCTAssertEqual(viewModel.currentPage, 1)
        XCTAssertEqual(viewModel.totalPages, 1)
        XCTAssertFalse(viewModel.isLoading)
    }

    func testFetchMoviesWithPagination() async throws {
        // given
        let mockMovie1 = Movie(id: 1, originalTitle: "Test Movie 1", overview: "Overview", posterPath: "path", releaseDate: "2023-01-01")
        let mockResponse1 = FetchMoviesResponse(page: 1, movies: [mockMovie1], totalPages: 2)
        fetchMoviesUseCase.responseData = try JSONEncoder().encode(mockResponse1)
        mockRepository.result = .success(mockResponse1)

        // when
        let page1Expectation = XCTestExpectation(description: "Fetch movies completes")

        Task {
            await viewModel.fetchMovies()
            page1Expectation.fulfill()
        }

        await fulfillment(of: [page1Expectation], timeout: 3)

        // then
        XCTAssertEqual(viewModel.movies.count, 1)
        XCTAssertEqual(viewModel.currentPage, 1)
        XCTAssertEqual(viewModel.totalPages, 2)
        XCTAssertFalse(viewModel.isLoading)

        // Mock second page response
        let mockMovie2 = Movie(id: 2, originalTitle: "Test Movie 2", overview: "Overview", posterPath: "path", releaseDate: "2023-01-02")
        let mockResponse2 = FetchMoviesResponse(page: 2, movies: [mockMovie2], totalPages: 2)
        fetchMoviesUseCase.responseData = try JSONEncoder().encode(mockResponse2)
        mockRepository.result = .success(mockResponse2)

        let page2Expectation = XCTestExpectation(description: "Fetch movies completes")
        
        // Perform fetchMovies and fulfill expectation
        Task {
            await viewModel.fetchMovies()
            page2Expectation.fulfill()
        }

        // Await the fulfillment of the expectation
        await fulfillment(of: [page2Expectation], timeout: 3)

        XCTAssertEqual(viewModel.movies.count, 2)
        XCTAssertEqual(viewModel.movies[1].originalTitle, "Test Movie 2")
        XCTAssertEqual(viewModel.currentPage, 2)
        XCTAssertEqual(viewModel.totalPages, 2)
        XCTAssertFalse(viewModel.isLoading)
    }

    func testFetchMoviesEarlyReturn() async {
        // given
        viewModel.isLoading = true

        // when
        await viewModel.fetchMovies()

        // then
        XCTAssertEqual(viewModel.movies.count, 0)
        XCTAssertTrue(viewModel.isLoading)

        // given
        viewModel.isLoading = false
        viewModel.currentPage = 2
        viewModel.totalPages = 1

        // when
        await viewModel.fetchMovies()

        // then
        XCTAssertEqual(viewModel.movies.count, 0)
        XCTAssertFalse(viewModel.isLoading)
    }

    func testResetMovies() async throws {
        // given
        viewModel.movies = [Movie(id: 1, originalTitle: "Test Movie", overview: "Overview", posterPath: "path", releaseDate: "2023-01-01")]
        viewModel.currentPage = 1
        viewModel.totalPages = 2
        viewModel.isLoading = true

        // when
        let expectation = XCTestExpectation(description: "Movies list reset")

        // Perform fetchMovies and fulfill expectation
        Task {
            viewModel.resetMovies()
            expectation.fulfill()
        }

        // Await the fulfillment of the expectation
        await fulfillment(of: [expectation], timeout: 3)

        // then
        XCTAssertEqual(viewModel.movies.count, 0)
        XCTAssertEqual(viewModel.currentPage, 0)
        XCTAssertEqual(viewModel.totalPages, 1)
        XCTAssertFalse(viewModel.isLoading)
    }
}
