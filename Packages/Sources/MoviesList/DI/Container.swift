//
//  Container.swift
//  
//
//  Created by AmrFawaz on 07/07/2024.
//

import Foundation
import MovieDetails

final class Container {
    static func getMovieDdetailsViewModel(movieID: Int) -> MovieDetailsViewModel {
        var fetchMovieDetailsUseCase: DefaultFetchMovieDetailsUseCase {
            let movieDetailsRepository = MovieDetailsRepositoryImpl(api: MovieDetailsAPI())
            return DefaultFetchMovieDetailsUseCase(repository: movieDetailsRepository)
        }

        return MovieDetailsViewModel(movieID: movieID, fetchMovieDetailsUseCase: fetchMovieDetailsUseCase)
    }
}
