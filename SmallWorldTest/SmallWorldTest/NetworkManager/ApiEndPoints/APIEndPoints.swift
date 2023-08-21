//
//  ApiConstant.swift
//  SmallWorldTest
//
//  Created by shairjeel ahmed on 20/08/2023.
//

import Foundation

protocol APIEndpointProtocol {
    var path: String {get}
    var parameters: [String: Any]? {get}
    var url: URL {get}
    var apiKey: String? { get }
}

enum APIEndpoint: APIEndpointProtocol {
    case popularMoviesList
    case MovieDetails(movieID: Int)
    
    static var baseURL: String {
        return "https://api.themoviedb.org/3/movie"
    }
    
    
    var path: String {
        switch self {
        case .popularMoviesList:
            return "/popular"
        case .MovieDetails(let movieID):
            return "/\(movieID)"
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        default:
            return nil
        }
    }
    
    var apiKey: String? {
        switch self {
        default:
            return "896a23bae00d5bf0f7a81f41e1d675ad"
        }
    }
    
    
    var url: URL {
        var components = URLComponents(string: APIEndpoint.baseURL + self.path)
        
        var queryItems: [URLQueryItem] = []
        
        // Append API key if available
        if let apiKey = self.apiKey {
            queryItems.append(URLQueryItem(name: "api_key", value: apiKey))
        }
        
        // Append other query parameters if available
        if let parameters = self.parameters {
            queryItems.append(contentsOf: parameters.map { URLQueryItem(name: $0, value: "\($1)") })
        }
        
        components?.queryItems = queryItems.isEmpty ? nil : queryItems
        
        guard let finalURL = components?.url else {
            fatalError("Failed to construct final URL")
        }
        
        return finalURL
    }
}
