//
//  Movie.swift
//  
//
//  Created by AmrFawaz on 04/07/2024.
//

import Foundation

public struct Movie: Codable, Identifiable, Hashable {
    public let id: Int

    let originalTitle: String
    let overview: String
    let posterPath: String
    let releaseDate: String

    enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }
}

// MARK: - Mocks

#if DEBUG
extension Movie {
    public static var mockedMovie: Movie {
        Movie (
            id: 653346,
            originalTitle: "Kingdom of the Planet of the Apes",
            overview: "Several generations in the future following Caesar's reign, apes are now the dominant species and live harmoniously while humans have been reduced to living in the shadows. As a new tyrannical ape leader builds his empire, one young ape undertakes a harrowing journey that will cause him to question all that he has known about the past and to make choices that will define a future for apes and humans alike.",
            posterPath: "/gKkl37BQuKTanygYQG1pyYgLVgf.jpg",
            releaseDate: "2024-05-08"
        )
    }
    
    public static var mockedMovies: [Movie] {
        [
            Movie (
                id: 653346,
                originalTitle: "Kingdom of the Planet of the Apes",
                overview: "Several generations in the future following Caesar's reign, apes are now the dominant species and live harmoniously while humans have been reduced to living in the shadows. As a new tyrannical ape leader builds his empire, one young ape undertakes a harrowing journey that will cause him to question all that he has known about the past and to make choices that will define a future for apes and humans alike.",
                posterPath: "/gKkl37BQuKTanygYQG1pyYgLVgf.jpg",
                releaseDate: "2024-05-08"
            ),
            Movie(
                id: 573435,
                originalTitle: "Bad Boys: Ride or Die",
                overview: "After their late former Captain is framed, Lowrey and Burnett try to clear his name, only to end up on the run themselves.",
                posterPath: "/nP6RliHjxsz4irTKsxe8FRhKZYl.jpg",
                releaseDate: "2024-06-05"
            ),
            Movie(
                id: 1022789,
                originalTitle: "Inside Out 2",
                overview: "Teenager Riley's mind headquarters is undergoing a sudden demolition to make room for something entirely unexpected: new Emotions! Joy, Sadness, Anger, Fear and Disgust, who’ve long been running a successful operation by all accounts, aren’t sure how to feel when Anxiety shows up. And it looks like she’s not alone.",
                posterPath: "/vpnVM9B6NMmQpWeZvzLvDESb2QY.jpg",
                releaseDate: "2024-06-11"
            ),
            Movie(
                id: 823464,
                originalTitle: "Godzilla x Kong: The New Empire",
                overview: "Following their explosive showdown, Godzilla and Kong must reunite against a colossal undiscovered threat hidden within our world, challenging their very existence – and our own.",
                posterPath: "/z1p34vh7dEOnLDmyCrlUVLuoDzd.jpg",
                releaseDate: "2024-03-27"
            ),
            Movie(
                id: 1001311,
                originalTitle: "Under Paris",
                overview: "In the Summer of 2024, Paris is hosting the World Triathlon Championships on the Seine for the first time. Sophia, a brilliant scientist, learns from Mika, a young environmental activist, that a large shark is swimming deep in the river. To avoid a bloodbath at the heart of the city, they have no choice but to join forces with Adil, the Seine river police commander.",
                posterPath: "/qZPLK5ktRKa3CL4sKRZtj8UlPYc.jpg",
                releaseDate: "2024-06-05"
            ),
            Movie(
                id: 929590,
                originalTitle: "Civil War",
                overview: "In the near future, a group of war journalists attempt to survive while reporting the truth as the United States stands on the brink of civil war.",
                posterPath: "/sh7Rg8Er3tFcN9BpKIPOMvALgZd.jpg",
                releaseDate: "2024-04-10"
            )
        ]
    }
}
#endif
