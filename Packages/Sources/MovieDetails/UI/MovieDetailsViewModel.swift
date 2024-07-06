//
//  MovieDetailsViewModel.swift
//
//
//  Created by AmrFawaz on 04/07/2024.
//

import Foundation
import AppConfigurations

public final class MovieDetailsViewModel: ObservableObject {
    @Published private var movieDetails: MovieDetails?

    let movieID: Int

    private let fetchMovieDetailsUseCase: FetchMovieDetailsUseCase

    public init(movieID: Int, fetchMovieDetailsUseCase: FetchMovieDetailsUseCase) {
        self.movieID = movieID
        self.fetchMovieDetailsUseCase = fetchMovieDetailsUseCase
    }

    var title: String {
        movieDetails?.title ?? ""
    }

    var posterImagePath: String {
        guard let path = movieDetails?.posterPath else { return "" }
        return AppConstants.moviePosterRoot.rawValue + path
    }

    var releaseDate: String {
        movieDetails?.releaseDate ?? ""
    }

    var genres: String {
        guard let genres = movieDetails?.genres, !genres.isEmpty else { return "" }
        return genres.map({ $0.name }).joined(separator: ", ")
    }

    var overview: String {
        guard let overview = movieDetails?.overview else { return "" }
        return overview
    }

    var duration: String {
        guard let totalMinutes = movieDetails?.runtime else { return "" }

        let hours = totalMinutes / 60
        let minutes = totalMinutes % 60
        return "\(hours)h \(minutes)m"
    }
    var rating: String {
        guard let rating = movieDetails?.voteAverage else { return "" }
        return String(format: "%.2f %%", rating * 10)
    }
}

extension MovieDetailsViewModel {
    @MainActor
    func fetchMovieDetails() async -> Void {
        
        do {
            movieDetails = try await fetchMovieDetailsUseCase.execute(movieID: movieID)
        } catch {
            print("Fetch failed: \(error.localizedDescription)")
        }
    }
}
