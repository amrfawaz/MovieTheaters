//
//  FetchPopularMoviesRequest.swift
//
//
//  Created by AmrFawaz on 04/07/2024.
//

import Foundation
import AppConfigurations
import Networking

public struct FetchPopularMoviesRequest {
    private enum Constants {
        static let languageParam = ["language": "en-US"]
        static let popoularEndpoint = "/popular"
    }

    public var params: [String : String] = Constants.languageParam

    public var request: URLRequest? {
        let urlString = AppConstants.baseUrl.rawValue + Constants.popoularEndpoint

        guard let url = URL(string: urlString) else { return nil }

        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }

        guard let url = components?.url else { return nil }

        var request = URLRequest(url: url)
        request.setValue(AppConstants.accessToken.rawValue, forHTTPHeaderField: "Authorization")
        request.setValue(AppConstants.accept.rawValue, forHTTPHeaderField: "accept")
        request.httpMethod = HTTPMethod.get.rawValue
        return request
    }
}
