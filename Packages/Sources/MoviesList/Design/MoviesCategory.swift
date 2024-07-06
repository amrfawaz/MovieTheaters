//
//  MoviesCategory.swift
//
//
//  Created by AmrFawaz on 05/07/2024.
//

import Foundation

public enum MoviesCategory {
    case nowPlaying
    case popular
    case upcoming

    var title: String {
        switch self {
        case .nowPlaying:
            "Now Playing"
        case .popular:
            "Popular Movies"
        case .upcoming:
            "Upcoming Movies"
        }
    }
}
