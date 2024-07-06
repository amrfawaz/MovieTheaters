//
//  NowPlayingMoviesView.swift
//  
//
//  Created by AmrFawaz on 05/07/2024.
//

import SwiftUI
import CoreInterface
import MovieDetails

public struct NowPlayingMoviesView: View {
    @ObservedObject private var viewModel: NowPlayingMoviesViewModel

    public init(viewModel: NowPlayingMoviesViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        MoviesView(viewModel: viewModel)
    }
}
