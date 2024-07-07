//
//  FetchPopularMoviesRequest.swift
//
//
//  Created by AmrFawaz on 04/07/2024.
//

import Foundation
import AppConfigurations
import Networking

struct FetchPopularMoviesRequest: FetchMoviesRequest {
    var params: [String: String] = ["language": "en-US"]
    var endPoint: String {
        return "/popular"
    }
}
