//
//  UpcomingMoviesView.swift
//  
//
//  Created by AmrFawaz on 05/07/2024.
//

import SwiftUI
import CoreInterface
import MovieDetails

public struct UpcomingMoviesView: View {
    @ObservedObject private var viewModel: UpcomingMoviesViewModel

    public init(viewModel: UpcomingMoviesViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        MoviesView(viewModel: viewModel)
    }
}
