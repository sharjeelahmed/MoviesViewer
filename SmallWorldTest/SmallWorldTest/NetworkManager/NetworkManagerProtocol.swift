//
//  NetworkManagerProtocol.swift
//  SmallWorldTest
//
//  Created by shairjeel ahmed on 20/08/2023.
//

import Foundation

protocol NetworkManagerProtocol {
    func request<T: Decodable>(url: URLRequest) async throws -> T
}
