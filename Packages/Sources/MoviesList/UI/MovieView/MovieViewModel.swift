//
//  MovieViewModel.swift
//
//
//  Created by AmrFawaz on 04/07/2024.
//

import AppConfigurations
import Combine
import Foundation

enum MovieViewAction {
    case didTapMovieCard
}

final class MovieViewModel: ObservableObject {
    @Published var movie: Movie

    let subject = PassthroughSubject<MovieViewAction, Never>()

    init(movie: Movie) {
        self.movie = movie
    }

    var posterImagePath: String {
        AppConstants.moviePosterRoot.rawValue + movie.posterPath
    }

    var movieName: String {
        movie.originalTitle
    }

    var movieReleaseDate: String {
        movie.releaseDate
    }
}

#if DEBUG
extension MovieViewModel {
    static var mockListCard: MovieViewModel {
        MovieViewModel(movie: .mockedMovie)
    }
}
#endif
