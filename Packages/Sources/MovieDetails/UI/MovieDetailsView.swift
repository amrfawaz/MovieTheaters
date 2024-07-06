//
//  MovieDetailsView.swift
//
//
//  Created by AmrFawaz on 04/07/2024.
//

import SwiftUI
import CoreInterface

public struct MovieDetailsView: View {
    @ObservedObject var viewModel: MovieDetailsViewModel
    @Binding var path: NavigationPath

    public init(viewModel: MovieDetailsViewModel, path: Binding<NavigationPath>) {
        self.viewModel = viewModel
        self._path = path
    }

    public var  body: some View {
        ScrollView {
            VStack(spacing: .zero) {
                ZStack(alignment: .topLeading) {
                    // Background Image
                    backgroundImage

                    headerButtons
                        .padding()
                }
                .frame(height: Style.Size.moviePosterImageHeight)

                details

                Spacer()
            }
            .navigationBarBackButtonHidden(true)
            .task {
                await viewModel.fetchMovieDetails()
            }
        }
    }
}

// MARK: - Top Image View
private extension MovieDetailsView {
    var backgroundImage: some View {
        AsyncImage(
            url: URL(
                string: viewModel.posterImagePath
            )
        ) { image in
            image.resizable()
        } placeholder: {
            Color.gray
        }
    }

    var headerButtons: some View {
        HStack {
            backButton
            Spacer()
        }
    }

    var backButton: some View {
        Button(action: {
            path.removeLast()
        }) {
            Image(systemName: "chevron.left")
                .foregroundColor(.black)
                .padding(10)
                .background(Color.white)
                .clipShape(Circle())
                .shadow(radius: 3)
        }
    }

    var titleView: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                title

                Spacer()
            }
        }
    }

    var title: some View {
        Text(viewModel.title)
            .typography(.heading02)
            .foregroundStyle(.black)
    }
}

// MARK: - Details View

extension MovieDetailsView {
    var details: some View {
        VStack(
            alignment: .leading,
            spacing: Style.Spacing.lg
        ) {
            titleView

            infoView(
                title: "Overview",
                value: viewModel.overview
            )

            infoView(
                title: "Release Date",
                value: viewModel.releaseDate
            )

            infoView(
                title: "Genres",
                value: viewModel.genres
            )

            infoView(
                title: "Duration",
                value: viewModel.duration
            )

            infoView(
                title: "Rating",
                value: viewModel.rating
            )
        }
        .padding()
    }

    func infoView(title: String, value: String) -> some View {
        VStack(
            alignment: .leading,
            spacing: Style.Spacing.xxs
        ) {
            Text(title)
                .typography(.heading02)
                .foregroundStyle(.black)

            Text(value)
                .typography(.callout)
                .foregroundStyle(.gray)
                .fixedSize(horizontal: false, vertical: true)


        }
    }
}
