//
//  ScreenNameViewModel.swift
//  SmallWorldTest
//
//  Created by shairjeel ahmed on 20/08/2023.
//

import Foundation
import UIKit

protocol MoviesListViewModelProtocol {
    func getData()
}
class MoviesListViewModel: MoviesListViewModelProtocol {
    var moviesRepository: MoviesRepositoryProtocol
    
    var array: [MovieViewModelProtocol] = []
    var onLoadData: (([MovieViewModelProtocol]) -> Void)?
    var navigateToDetail: ((DetailMovieViewModel) -> Void)?
    
    var onApiRequestFailure: ((AlertItem) -> Void)?
    
    init (moviesRepository: MoviesRepositoryProtocol) {
        self.moviesRepository = moviesRepository
    }
    
    func navigateToMovieDetails(selectedIndex: Int) {
        let detailVc = DetailMovieViewModel(moviesRepository: moviesRepository, movieID: array[selectedIndex].id)
        navigateToDetail?(detailVc)
    }
    
    func getData() {
        Task {
            do {
                let movies = try await moviesRepository.fetchMovies()
                guard let movies = movies else {
                    print("No movies Found")
                    return
                }
                array = movies.map { MovieViewModel($0) }
                onLoadData?(array)
            } catch {
                if let networkError = error as? NetworkError {
                    switch networkError {
                    case .invalidResponse:
                        self.onApiRequestFailure?(AlertContext.invalidResponse)
                    case .invalidData:
                        self.onApiRequestFailure?(AlertContext.invalidData)
                    }
                }
            }
        }
    }
}

extension MoviesListViewModel {
    
    static var moviesListViewModelBuilder = MoviesListViewModel.init(moviesRepository:
                                                                        MoviesRepository(
                                                                            networkManager:
                                                                                NetworkManger(),
                                                                            reachabilityService:
                                                                                AlamofireNetworkReachabilityService(),
                                                                            movieRealmManager:
                                                                                MoviesRealmManager.shared))
}



