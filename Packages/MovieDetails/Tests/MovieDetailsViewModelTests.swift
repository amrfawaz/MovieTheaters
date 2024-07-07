//
//  MovieDetailsViewModelTests.swift
//
//
//  Created by AmrFawaz on 07/07/2024.
//

import XCTest
import Combine

@testable import MovieDetails
@testable import Networking
 
final class MovieDetailsViewModelTests: XCTestCase {
    var mockNetworkManager: MockNetworkManager!
    var movieDetailsAPI: MovieDetailsAPI!
    var useCase: DefaultFetchMovieDetailsUseCase!
    var mockRepository: MovieDetailsRepositoryImpl!
    var viewModel: MovieDetailsViewModel!


    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        movieDetailsAPI = MovieDetailsAPI(networkManager: mockNetworkManager)
        mockRepository = MovieDetailsRepositoryImpl(api: movieDetailsAPI)
        useCase = DefaultFetchMovieDetailsUseCase(repository: mockRepository)
    }

    override func tearDown() {
        movieDetailsAPI = nil
        mockNetworkManager = nil
        mockRepository = nil
        useCase = nil
        super.tearDown()
    }

    func testFetchMovieDetailsSuccess() async throws {
        //given

        let movieDetails = MovieDetails.mockedMovieDetails
        let data = try JSONEncoder().encode(movieDetails)
        mockNetworkManager.responseData = data

        // when
        let viewModel = MovieDetailsViewModel(movieID: MovieDetails.mockedMovieDetails.id, fetchMovieDetailsUseCase: useCase)
        await viewModel.fetchMovieDetails()

        // then
        XCTAssertEqual(viewModel.title, "Kingdom of the Planet of the Apes")
        XCTAssertEqual(viewModel.genres, "Science Fiction, Adventure, Action")
        XCTAssertEqual(viewModel.overview, "Several generations in the future following Caesar's reign, apes are now the dominant species and live harmoniously while humans have been reduced to living in the shadows. As a new tyrannical ape leader builds his empire, one young ape undertakes a harrowing journey that will cause him to question all that he has known about the past and to make choices that will define a future for apes and humans alike.")
        XCTAssertEqual(viewModel.releaseDate, "2024-05-08")
        XCTAssertEqual(viewModel.duration, "2h 25m")
        XCTAssertEqual(viewModel.rating, "68.21 %")
    }

    func testFetchMovieDetailsFailure() async throws {
        // given
        mockNetworkManager.responseError = .serverError

        // when
        let viewModel = MovieDetailsViewModel(movieID: 653346, fetchMovieDetailsUseCase: useCase)
        await viewModel.fetchMovieDetails()

        // then
        XCTAssertEqual(viewModel.title, "")
        XCTAssertEqual(viewModel.genres, "")
        XCTAssertEqual(viewModel.overview, "")
        XCTAssertEqual(viewModel.releaseDate, "")
        XCTAssertEqual(viewModel.duration, "")
        XCTAssertEqual(viewModel.rating, "")
    }
}
