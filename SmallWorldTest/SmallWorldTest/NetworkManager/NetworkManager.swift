//
//  NetworkManager.swift
//  SmallWorldTest
//
//  Created by shairjeel ahmed on 20/08/2023.
//

import Foundation

enum NetworkError: Error {
    case invalidResponse
    case invalidData
}

class NetworkManger: NetworkManagerProtocol {
   
    func request<T: Decodable>(url: URLRequest) async throws -> T {
        
        
        let (data, response) = try await URLSession.shared.data(for: url)
        print(response)
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse
        }
        
        if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                 let jsonString = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
                    if let jsonString = String(data: jsonString, encoding: .utf8) {
                        print(jsonString)
                    }
                }
        
        do {
            let decoder = JSONDecoder()
            let response = try decoder.decode(T.self, from: data)
            return response
        }
        catch {
            print(error)
            throw NetworkError.invalidData
        }
    }
}
