//
//  MovieListViewModelTest.swift
//  SmallWorldTestTests
//
//  Created by shairjeel ahmed on 21/08/2023.
//

import XCTest

@testable import SmallWorldTest

class MoviesListViewModelTests: XCTestCase {
    
    var mockMoviesRepository: MockMoviesRepository!
    var viewModel: MoviesListViewModel!

    override func setUp() {
        super.setUp()
        mockMoviesRepository = MockMoviesRepository()
        viewModel = MoviesListViewModel(moviesRepository: mockMoviesRepository)
    }
    
    override func tearDown() {
        mockMoviesRepository = nil
        viewModel = nil
        super.tearDown()
    }

    func testFetchMoviesSuccess() {
        // Given
        let movie = Movie(id: 123, title: "Test Movie", originalTitle: "Test Original Movie")
        mockMoviesRepository.fetchMoviesReturnValue = [movie]
        
        // When
        viewModel.getData()
        
        // Then
        XCTAssertEqual(viewModel.array.count, 1)
        XCTAssertEqual(viewModel.array[0].name, "Test Movie")
    }
    
    func testFetchMoviesFailure() {
        // Given
        mockMoviesRepository.fetchMoviesError = NetworkError.invalidResponse
        
        // When
        viewModel.getData()
        
        // Then
        XCTAssertEqual(viewModel.array.count, 0)
        // You can also assert that the onApiRequestFailure closure was called
    }
    
    // Add more test cases for other scenarios
    
}
