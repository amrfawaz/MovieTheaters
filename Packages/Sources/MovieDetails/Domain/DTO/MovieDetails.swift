//
//  MovieDetails.swift
//  
//
//  Created by AmrFawaz on 04/07/2024.
//

import Foundation

public struct MovieDetails: Codable {
    let genres: [Genre]
    let id: Int
    let originCountry: [String]
    let overview, posterPath, releaseDate: String
    let runtime: Int
    let title: String
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case genres, id
        case originCountry = "origin_country"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case runtime, title
        case voteAverage = "vote_average"
    }
}

// MARK: - Genre

struct Genre: Codable {
    let id: Int
    let name: String
}


// MARK: - Mocks

#if DEBUG
extension MovieDetails {
    public static var mockedMovieDetails: MovieDetails {
        MovieDetails(
            genres: mockedGenre,
            id: 653346,
            originCountry: ["US"],
            overview: "Several generations in the future following Caesar's reign, apes are now the dominant species and live harmoniously while humans have been reduced to living in the shadows. As a new tyrannical ape leader builds his empire, one young ape undertakes a harrowing journey that will cause him to question all that he has known about the past and to make choices that will define a future for apes and humans alike.",
            posterPath: "/gKkl37BQuKTanygYQG1pyYgLVgf.jpg",
            releaseDate: "2024-05-08",
            runtime: 145,
            title: "Kingdom of the Planet of the Apes",
            voteAverage: 6.821
        )
    }

    private static var mockedGenre: [Genre] {
        [
            Genre(
                id: 878,
                name: "Science Fiction"
            ),
            Genre(
                id: 12,
                name: "Adventure"
            ),
            Genre(
                id: 23,
                name: "Action"
            )
        ]
    }
}
#endif
