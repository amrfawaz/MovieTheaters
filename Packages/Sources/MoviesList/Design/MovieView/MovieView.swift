//
//  MovieView.swift
//
//
//  Created by AmrFawaz on 04/07/2024.
//

import CoreInterface
import SwiftUI

struct MovieView: View {
    @ObservedObject private var viewModel: MovieViewModel

    init(viewModel: MovieViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            backgroundImage
            overlayView
            content
                .padding(.all, Style.Spacing.md)
        }
        .frame(height: Style.Size.movieCardHeight)
        .clipShape(.rect(cornerRadius: Style.Spacing.md))
        .padding(.horizontal, Style.Spacing.md)
        .padding(.top, Style.Spacing.sm)
        .onTapGesture {
            viewModel.subject.send(.didTapMovieCard)
        }
    }

    var backgroundImage: some View {
        Group {
            if let url = URL(string: viewModel.posterImagePath) {
                Rectangle()
                    .asyncImage(url: url)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    var overlayView: some View {
        Rectangle()
            .foregroundStyle(.black)
            .opacity(0.4)
    }

    var content: some View {
        VStack(
            alignment: .leading,
            spacing: Style.Spacing.xs
        ) {
            header
            Spacer()
            releaseDate
        }
    }
}

// MARK: - Content Views

private extension MovieView {
    var header: some View {
        HStack(alignment: .top, spacing: Style.Spacing.xs) {
            title
                .foregroundStyle(.white)
            Spacer()
        }
    }

    var title: some View {
        Text(viewModel.movieName)
            .typography(.heading02)
            .foregroundStyle(.white)
    }

    var releaseDate: some View {
        Text(viewModel.movieReleaseDate)
            .typography(.body01)
            .foregroundStyle(.white)
    }
}

// MARK: - Preview

#if DEBUG
struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            movie(.mockListCard)
        }
    }

    private static func movie(
        _ viewModel: MovieViewModel
    ) -> some View {
        MovieView(viewModel: viewModel)
    }
}
#endif
