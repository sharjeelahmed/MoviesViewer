//
//  DetailMovieViewModelTests.swift
//  SmallWorldTestTests
//
//  Created by shairjeel ahmed on 22/08/2023.
//

import XCTest
import RealmSwift
@testable import SmallWorldTest

class DetailMovieViewModelTests: XCTestCase {
    
    var mockMoviesRepository: MoviesRepositoryProtocol!
    var viewModel: DetailMovieViewModel!
    
    override func setUp() {
        super.setUp()
        // Set up the mock repository here
    }
    
    override func tearDown() {
        mockMoviesRepository = nil
        viewModel = nil
        super.tearDown()
    }

    func testFetchMovieDetailsSuccess() {
        mockMoviesRepository = MockMoviesRepository_Success()
        let movieID = 123
        viewModel = DetailMovieViewModel(moviesRepository: mockMoviesRepository, movieID: movieID)

        let expectation = XCTestExpectation(description: "Fetch movie details success expectation")

        viewModel.fetchMovieDetails()
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)

        XCTAssertNotNil(viewModel.movieDetails)
    }
    
    func testFetchMovieDetailsFailure() {
        mockMoviesRepository = MockMoviesRepository_Faiure()
        let movieID = 123
        viewModel = DetailMovieViewModel(moviesRepository: mockMoviesRepository, movieID: movieID)
        

        let expectation = XCTestExpectation(description: "Fetch movie details failure expectation")

        viewModel.fetchMovieDetails()
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)

        XCTAssertNil(viewModel.movieDetails)
    }
    
    
}
