//
//  File.swift
//  SmallWorldTest
//
//  Created by shairjeel ahmed on 21/08/2023.
//

import Foundation

protocol DetailMovieViewModelProtocol {
    var movieDetails: MovieDetailsViewModelProtocol? { get }
    func fetchMovieDetails()
}

class DetailMovieViewModel: DetailMovieViewModelProtocol {
    var movieDetails: MovieDetailsViewModelProtocol?
    var moviesRepository: MoviesRepositoryProtocol
    var movieID: Int
    var onLoadData: ((MovieDetailsViewModelProtocol) -> Void)?

    init(moviesRepository: MoviesRepositoryProtocol, movieID: Int ) {
        self.moviesRepository = moviesRepository
        self.movieID = movieID
    }

    func fetchMovieDetails() {
        Task {
            do {
                guard let details = try await moviesRepository.fetchMoviesDetails(movieID: self.movieID) else {
                    print("no data found")
                    return
                }
                
                movieDetails = MovieDetailsViewModel(details)
                print(details)
                guard let movieDetails = movieDetails else {return}
                onLoadData?(movieDetails)
            } catch {
                // Handle errors
            }
        }
    }
}
