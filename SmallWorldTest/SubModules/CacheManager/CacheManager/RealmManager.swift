//
//  RealmManager.swift
//  CacheManager
//
//  Created by shairjeel ahmed on 21/08/2023.
//

import Foundation
import RealmSwift

/*class RealmManager {
    static let shared = RealmManager()

    private let realm: Realm

    private init() {
        do {
            realm = try Realm()
        } catch {
            fatalError("Failed to initialize Realm: \(error)")
        }
    }

    func storeMovies(_ movies: [Movie]) {
        do {
            try realm.write {
                realm.add(movies, update: .modified)
            }
        } catch {
            print("Failed to store movies in Realm: \(error)")
        }
    }

    func fetchMovies() -> [Movie] {
        return Array(realm.objects(Movie.self))
    }
}*/
