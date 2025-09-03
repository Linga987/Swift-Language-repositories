//
//  APIEndpoint.swift
//  iOSAssignment
//
//  Created by Lingaswami Karingula on 02/09/25.
//

import Foundation

/// Build the request URL using URLComponents
enum APIEndpoint {
    case fetchSwiftRepos
    
    var url: URL? {
        var components = URLComponents(string: "https://api.github.com/search/repositories")
        switch self {
        case .fetchSwiftRepos:
            components?.queryItems = [
                URLQueryItem(name: "q", value: "language:swift"),
                URLQueryItem(name: "sort", value: "stars"),
                URLQueryItem(name: "order", value: "desc")
            ]
        }
        return components?.url
    }
}
