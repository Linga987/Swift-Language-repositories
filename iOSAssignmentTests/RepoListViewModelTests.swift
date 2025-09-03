//
//  RepoListViewModelTests.swift
//  RepoListViewModelTests
//
//  Created by Lingaswami Karingula on 01/09/25.
//

import XCTest
@testable import iOSAssignment

final class RepoListViewModelTests: XCTestCase {

    
    var viewModel: RepoListViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = RepoListViewModel()
        
        // Common test data
        let repo1 = Items(id: 1, name: "Alamofire", html_url: "https://github.com/alamofire")
        let repo2 = Items(id: 2, name: "RxSwift", html_url: "https://github.com/RxSwift")
        viewModel.setReposForTesting([repo1, repo2])
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testSearchRepos_WithMatchingName_ShouldFilterCorrectly() {
        // When
        viewModel.searchRepos("rx")
        
        // Then
        XCTAssertEqual(viewModel.filteredRepos?.count, 1)
        XCTAssertEqual(viewModel.filteredRepos?.first?.name, "RxSwift")
    }
    
    func testSearchRepos_WithEmptyText_ShouldReturnAll() {
        // When
        viewModel.searchRepos("")
        
        // Then
        XCTAssertEqual(viewModel.filteredRepos?.count, 2)
    }
}
