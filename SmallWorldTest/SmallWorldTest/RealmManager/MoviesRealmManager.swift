//
//  RealmManager.swift
//  CacheManager
//
//  Created by shairjeel ahmed on 21/08/2023.
//

import Foundation
import RealmSwift

protocol MoviesRealmManagerProtocol {
    func storeMovies(_ movies: [Movie])
    func storeMovieDetails(_ movie: Movie)
    func fetchMovies() -> [Movie]?
    func fetchMovieDetails(movieID: Int) -> Movie?
}

class MoviesRealmManager: MoviesRealmManagerProtocol {
    static let shared = MoviesRealmManager()


    private init() {
        
        /*do {
            realm = try Realm()
        } catch {
            fatalError("Failed to initialize Realm: \(error)")
        }*/
    }

    func storeMovies(_ movies: [Movie]) {
        do {
            let realm = try Realm()

            try realm.write {
                realm.add(movies, update: .modified)
            }
        } catch {
            print("Failed to store movies in Realm: \(error)")
        }
    }
    
    func storeMovieDetails(_ movie: Movie) {
        do {
            let realm = try Realm()

            try realm.write {
                realm.add(movie, update: .modified)
            }
        } catch {
            print("Failed to store movies in Realm: \(error)")
        }
    }

    func fetchMovies() -> [Movie]? {
        do {
            let realm = try Realm()
            return Array(realm.objects(Movie.self))
        } catch {
            print("Failed to retrive movies in Realm: \(error)")
            return nil
        }
    }
    
    func fetchMovieDetails(movieID: Int) -> Movie? {
        do {
            let realm = try Realm()
            return realm.object(ofType: Movie.self, forPrimaryKey: movieID)
        }catch {
            print("Failed to retrive movie details in Realm: \(error)")
            return nil
        }
    }
}
