//
//  AppetizerViewModelProtocol.swift
//  SmallWorldTest
//
//  Created by shairjeel ahmed on 20/08/2023.
//

import Foundation

protocol MovieViewModelProtocol {
    var id: Int {get}
    var name: String {get}
    var imageUrl: String {get}
    
}

struct MovieViewModel: MovieViewModelProtocol {
    var id: Int
    var name: String
    var imageUrl: String
    
    init (_ movie: Movie) {
        self.id = movie.id
        self.name = movie.title
        let imageWidth = Constants.AppConstants.posterImageWidthConstant
        self.imageUrl = Constants.AppConstants.MovieApiConstants.baseResourcesUrl + "w\(imageWidth)" + movie.posterPath
        print(imageUrl)
    }
}


