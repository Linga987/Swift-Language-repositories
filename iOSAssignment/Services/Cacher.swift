//
//  Cacher.swift
//  iOSAssignment
//
//  Created by Lingaswami Karingula on 02/09/25.
//

import Foundation

enum CacheError: Error {
    case encodingFailed
    case decodingFailed
    case noData
}

/// A simple caching utility for storing and retrieving repositories
class Cacher {
    
    private let key = "cachedRepos"
    
    func cacheResponse(_ response: [Items]?) throws {
        do {
            let data = try JSONEncoder().encode(response)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            throw CacheError.encodingFailed
        }
    }
    
    func getCachedResponse() throws -> [Items]? {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            throw CacheError.noData
        }
        do {
            return try JSONDecoder().decode([Items].self, from: data)
        } catch {
            throw CacheError.decodingFailed
        }
    }
}
