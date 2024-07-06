//
//  FetchNowPlayingMoviesRequest.swift
//
//
//  Created by AmrFawaz on 06/07/2024.
//

import Foundation

struct FetchNowPlayingMoviesRequest: FetchMoviesRequest {
    var params: [String: String] = ["language": "en-US"]
    var endPoint: String {
        return "/now_playing"
    }
}
