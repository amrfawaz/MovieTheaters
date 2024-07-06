//
//  NowPlayingMoviesViewModel.swift
//  
//
//  Created by AmrFawaz on 05/07/2024.
//

import Foundation
import Combine

public final class NowPlayingMoviesViewModel: MoviesViewModel {
    private var category: MoviesCategory
    private let fetchMoviesUseCase: FetchMoviesUseCase
    override public var pageTitle: String {
        category.title
    }

    public init(
        category: MoviesCategory,
        fetchMoviesUseCase: FetchMoviesUseCase
    ) {
        self.category = category
        self.fetchMoviesUseCase = fetchMoviesUseCase
        super.init(fetchMoviesUseCase: fetchMoviesUseCase)
    }

    override func createRequest() -> FetchMoviesRequest {
        FetchNowPlayingMoviesRequest()
    }
}
