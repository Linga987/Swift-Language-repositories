//
//  NetworkService.swift
//  iOSAssignment
//
//  Created by Lingaswami Karingula on 01/09/25.
//

import Foundation

/// Enum representing possible network-related errors
enum NetworkError: Error {
    case urlError
    case networkError(Error)
    case dataCannotParse
    case unknown
}

/// Service responsible for performing all network requests
class NetworkService {
    
    static let shared = NetworkService()
    private init() {}
    
    
    /// Fetches a list of Swift repositories from  API
    /// - Parameter completion: A closure that returns either:
    ///   - `.success(GHRepo)`: An array of decoded repositories
    ///   - `.failure(NetworkError)`: An error describing what went wrong
    func fetchRepositories(completion: @escaping (_ result: Result<GHRepo, NetworkError>) -> Void) {
        
        guard let url = APIEndpoint.fetchSwiftRepos.url else {
            completion(.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { dataResonse, result, error in
            if let error = error {
                completion(.failure(.networkError(error)))
            }
            
            guard let data = dataResonse else {
                completion(.failure(.unknown))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(GHRepo.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(.dataCannotParse))
            }
        }.resume()
    }
}
