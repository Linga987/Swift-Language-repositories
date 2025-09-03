//
//  RepoListViewModel.swift
//  iOSAssignment
//
//  Created by Lingaswami Karingula on 01/09/25.
//

import Foundation

/// RepoListViewModel  Handles fetching from cache + network, searching, and exposing data to the View
class RepoListViewModel {
    
    // MARK: - Properties
    private let cacher = Cacher()
    private(set) var repos: [Items]?
    private(set )var filteredRepos: [Items]?
    
    /// callback list of repos for UI binding
    var onUpdate: (() -> Void)?
    
    /// Error callback, triggered when something goes wrong
    var onError: ((String)-> Void)?
    
    func fetchRepos() {
        
        /// 1. Load from cache
        if let cached =  try? cacher.getCachedResponse() {
            self.repos = cached
            self.mapCellRepos()
            self.onUpdate?()
        }
        
        /// 2. Load from API
        NetworkService.shared.fetchRepositories { [weak self] result in
            switch result {
            case.success(let reposData):
                self?.repos = reposData.items
                do {
                    try self?.cacher.cacheResponse(reposData.items)
                } catch {
                    self?.onError?("Failed to cache data")
                }
                self?.mapCellRepos()
                self?.onUpdate?()
            case.failure(let error):
                self?.onError?("Network Error: \(error.localizedDescription)")
            }
        }
    }
    
    func numberOfRows(in section: Int) -> Int {
        return filteredRepos?.count ?? 0
    }
    
    func mapCellRepos() {
        self.filteredRepos = repos
    }
    
    /// Search repositories by name
    /// - Parameter text: User’s search query
    func searchRepos(_ text: String) {
        if text.isEmpty {
            filteredRepos = repos
        } else {
            filteredRepos = repos?.filter { repo in
                guard let name = repo.name else { return false }
                return name.lowercased().prefix(text.count) == text.lowercased()
            }
        }
        self.onUpdate?()
    }
    

#if DEBUG
    func setReposForTesting(_ repos: [Items]) {
        self.repos = repos
        self.filteredRepos = repos
    }
#endif
    
}
