
import Foundation
import Alamofire

protocol MoviesRepositoryProtocol {
    func fetchMovies() async throws -> [Movie]?
    func fetchMoviesDetails(movieID: Int) async throws -> Movie?
}

class MoviesRepository: MoviesRepositoryProtocol {
    private let networkManager: NetworkManagerProtocol
    private let reachabilityService: NetworkReachabilityService
    private let movieRealmManager: MoviesRealmManagerProtocol


    init(networkManager: NetworkManagerProtocol,
         reachabilityService: NetworkReachabilityService,
         movieRealmManager: MoviesRealmManagerProtocol) {
        self.networkManager = networkManager
        self.reachabilityService = reachabilityService
        self.movieRealmManager = movieRealmManager
    }
    
    func fetchMovies() async throws -> [Movie]? {
        let isInternetAvailable = reachabilityService.isReachable
        
        if isInternetAvailable {
            let moviesFromAPI = try await fetchMoviesFromAPI()
            
            try await storeMoviesInRealm(moviesFromAPI)
            return moviesFromAPI
        } else {
            return try await fetchMoviesFromRealm()
        }
    }
    
    func fetchMoviesDetails(movieID: Int) async throws -> Movie? {
        let isInternetAvailable = reachabilityService.isReachable
        
        if isInternetAvailable {
            let movie = try await fetchMovieDetailsFromAPI(movieID: movieID)
            try await storeMovieDetailsInRealm(movie)
            return movie
        } else {
            return try await fetchMovieDetailFromRealm(movieID: movieID)
        }
    }
    
    private func fetchMoviesFromAPI() async throws -> [Movie] {
        let url = APIEndpoint.popularMoviesList.url
        let response: MovieApiResponse = try await networkManager.request(url: URLRequest(url: url))
        let realmMovies = response.results.map { Movie(value: $0) }
        return realmMovies
    }
    
    private func fetchMovieDetailsFromAPI(movieID: Int) async throws -> Movie {
        let url = APIEndpoint.MovieDetails(movieID: movieID).url
        return try await networkManager.request(url: URLRequest(url: url))
    }
    
    private func fetchMoviesFromRealm() async throws -> [Movie]? {
        let cachedMovies = MoviesRealmManager.shared.fetchMovies()
        return cachedMovies
    }
    
    private func fetchMovieDetailFromRealm(movieID: Int) async throws -> Movie?{
        let cachedMovies = MoviesRealmManager.shared.fetchMovieDetails(movieID: movieID)
        return cachedMovies
    }
    
    private func storeMoviesInRealm(_ movies: [Movie]) async throws {
        try await  movieRealmManager.storeMovies(movies)
        //try await MoviesRealmManager.shared.storeMovies(movies)
    }
    
    private func storeMovieDetailsInRealm(_ movie: Movie) async throws {
        try await  movieRealmManager.storeMovieDetails(movie)
        //try await MoviesRealmManager.shared.storeMovieDetails(movie)
    }
}
