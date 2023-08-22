//
//  MovieListViewModelTest.swift
//  SmallWorldTestTests
//
//  Created by shairjeel ahmed on 21/08/2023.
//

import XCTest
import RealmSwift
@testable import SmallWorldTest

class MoviesListViewModelTests: XCTestCase {
    
    var mockMoviesRepository: MoviesRepositoryProtocol!
    var viewModel: MoviesListViewModel!
    var isSuccessTest: Bool = true
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        mockMoviesRepository = nil
        viewModel = nil
        super.tearDown()
    }

    func testFetchMoviesSuccess() {
        isSuccessTest = true // Set to true for success test
        
        // Set up the mock repository and view model here
        mockMoviesRepository = MockMoviesRepository_Success()
        viewModel = MoviesListViewModel(moviesRepository: mockMoviesRepository)

        let expectation = XCTestExpectation(description: "Fetch movies success expectation")

        viewModel.getMovies()
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)

        XCTAssertEqual(viewModel.array.count, 2)
        XCTAssertEqual(viewModel.array[0].name, "Sample Movie 1")
    }
    
    func testFetchMoviesFailure() {
        isSuccessTest = false // Set to false for failure test
        
        // Set up the mock repository and view model here
        mockMoviesRepository = MockMoviesRepository_Faiure()
        viewModel = MoviesListViewModel(moviesRepository: mockMoviesRepository)

        let expectation = XCTestExpectation(description: "Fetch movies failure expectation")

        viewModel.getMovies()
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)

        XCTAssertEqual(viewModel.array.count, 0) // No movies should be loaded
    }
    
    // Add more test cases for other scenarios
    
}
