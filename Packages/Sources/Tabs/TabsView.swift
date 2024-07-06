//
//  TabsViewModel.swift
//
//
//  Created by AmrFawaz on 05/07/2024.
//

import Combine
import CoreInterface
import SwiftUI
import MoviesList

public struct TabsView: View {
    private enum Constants {
        static let pageTitle = "Explore Popular Movies"
        static let errorTitle = "Error"
    }

    @StateObject private var viewModel: TabsViewModel

    @State private var cancellables = Set<AnyCancellable>()
    @State private var showAlert = false

    public init(viewModel: TabsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    public var body: some View {
        TabView {
            nowPlayingMovies
                .tabItem {
                    Image(systemName: "play.circle")
                    Text(viewModel.nowPlayingMoviesViewModel.pageTitle)
                }

            popularMovies
                .tabItem {
                    Image(systemName: "film")
                    Text(viewModel.popularMoviesViewModel.pageTitle)
                }

            upcomingMovies
                .tabItem {
                    Image(systemName: "calendar.circle")
                    Text(viewModel.popularMoviesViewModel.pageTitle)
                }
        }
    }
}

private extension TabsView {
    var popularMovies: some View {
        PopularMoviesView(
            viewModel: viewModel.popularMoviesViewModel
        )
    }

    var nowPlayingMovies: some View {
        NowPlayingMoviesView(
            viewModel: viewModel.nowPlayingMoviesViewModel
        )
    }

    var upcomingMovies: some View {
        UpcomingMoviesView(
            viewModel: viewModel.upcomingMoviesViewModel
        )
    }
}
