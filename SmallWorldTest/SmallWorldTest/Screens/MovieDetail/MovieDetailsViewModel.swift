//
//  MovieDetailsViewModel.swift
//  SmallWorldTest
//
//  Created by shairjeel ahmed on 21/08/2023.
//

import Foundation

protocol MovieDetailsViewModelProtocol {
    var title: String { get }
    var overview: String { get }
    var releaseDate: String { get }
    var voteAverage: String { get }
    var imageUrl: String { get }
    var genres: String { get }
    var productionCountries: String { get }
    var tagline: String { get }

}

struct MovieDetailsViewModel: MovieDetailsViewModelProtocol {
    var title: String
    var overview: String
    var releaseDate: String
    var voteAverage: String
    var imageUrl: String
    var genres: String
    var productionCountries: String
    var tagline: String

    init(_ movieDetails: Movie) {
        self.title = movieDetails.originalTitle
        self.overview = movieDetails.overView ?? ""
        self.releaseDate = movieDetails.releaseDate
        self.voteAverage = String(movieDetails.voteAverage)
        let imageWidth = "500"
        self.imageUrl = Constants.AppConstants.MovieApiConstants.baseResourcesUrl + "w\(imageWidth)" + movieDetails.posterPath
        self.genres = movieDetails.genres.reduce("", { $0 + ", " + $1.name })
        self.productionCountries = movieDetails.productionCountries.reduce("", { $0 + ", " + $1.name })
        self.tagline = movieDetails.tagline ?? ""
    }
}



