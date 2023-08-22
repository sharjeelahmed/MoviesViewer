//
//  File.swift
//  SmallWorldTestTests
//
//  Created by shairjeel ahmed on 21/08/2023.
//

import Foundation
@testable import SmallWorldTest
import RealmSwift


class MockMoviesRepository_Faiure: MoviesRepositoryProtocol {
    func fetchMovies() async throws -> [Movie]? {
            throw NetworkError.invalidData
        }
    
    func fetchMoviesDetails(movieID: Int) async throws -> SmallWorldTest.Movie? {
        throw NetworkError.invalidData
    }
}
