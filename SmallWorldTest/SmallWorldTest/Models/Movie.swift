//
//  Movie.swift
//  SmallWorldTest
//
//  Created by shairjeel ahmed on 20/08/2023.
//

import Foundation
import RealmSwift


class Movie: Object, Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var originalTitle: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var overView: String?
    @objc dynamic var voteAverage: Double = 0.0
    @objc dynamic var voteCount: Double = 0.0
    @objc dynamic var popularity: Double = 0.0
    @objc dynamic var releaseDate: String = ""
    @objc dynamic var backdropPath: String = ""
    @objc dynamic var posterPath: String = ""
    
    // movie Details Properties
    @objc dynamic var tagline: String?
    @objc dynamic var status: String?
    let productionCountries = List<ProductionCountry>()
    let genres = List<Genre>()
    
    enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title"
        case title
        case overView = "overview"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case popularity
        case releaseDate = "release_date"
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case tagline
        case status
        case productionCountries = "production_countries"
        case genres
    }

    override static func primaryKey() -> String? {
        return "id"
    }
}

class ProductionCountry: Object, Codable {
    @objc dynamic var iso3166_1: String = ""
    @objc dynamic var name: String = ""
}

class Genre: Object, Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
}

struct MovieApiResponse: Decodable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
