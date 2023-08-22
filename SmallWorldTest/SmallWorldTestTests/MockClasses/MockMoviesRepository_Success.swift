//
//  File.swift
//  SmallWorldTestTests
//
//  Created by shairjeel ahmed on 21/08/2023.
//

import Foundation
@testable import SmallWorldTest
import RealmSwift


class MockMoviesRepository_Success: MoviesRepositoryProtocol {
    func fetchMovies() async throws -> [Movie]? {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "Movies", ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
        let decoder = JSONDecoder()
        let movies = try! decoder.decode([Movie].self, from: data)
        
        // Mock the movies repository to return the movie
        return movies
        
    }
    
    func fetchMoviesDetails(movieID: Int) async throws -> SmallWorldTest.Movie? {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "Movies", ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
        let decoder = JSONDecoder()
        let movies = try! decoder.decode([Movie].self, from: data)
        
        // Mock the movies repository to return the movie
        return movies.first
    }
    
}
