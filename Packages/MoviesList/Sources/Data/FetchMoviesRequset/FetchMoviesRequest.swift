//
//  FetchMoviesRequest.swift
//
//
//  Created by AmrFawaz on 06/07/2024.
//

import Foundation
import AppConfigurations
import Networking

public protocol FetchMoviesRequest {
    var params: [String: String] { get set }
    var endPoint: String { get }
    var request: URLRequest? { get }
}

extension FetchMoviesRequest {
    var request: URLRequest? {
        let urlString = AppConstants.baseUrl.rawValue + endPoint

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
