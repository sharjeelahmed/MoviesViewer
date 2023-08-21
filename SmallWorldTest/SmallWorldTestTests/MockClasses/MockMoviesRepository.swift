//
//  File.swift
//  SmallWorldTestTests
//
//  Created by shairjeel ahmed on 21/08/2023.
//

import Foundation
@testable import SmallWorldTest
import RealmSwift


class MockMoviesRepository: MoviesRepositoryProtocol {
    
    var fetchMoviesReturnValue: [Movie] = []
    var fetchMoviesError: Error?
    
    func fetchMovies() async throws -> [Movie] {
        if let error = fetchMoviesError {
            throw error
        }
        return fetchMoviesReturnValue
    }
    
    // Implement other methods of the protocol if needed
    
}
