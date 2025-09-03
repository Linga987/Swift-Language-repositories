
//
//  GHRepo.swift
//  iOSAssignment
//
//  Created by Lingaswami Karingula on 01/09/25.
//

import Foundation

struct GHRepo : Codable {
    let items : [Items]?
    
    enum CodingKeys: String, CodingKey {
        case items = "items"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        items = try values.decodeIfPresent([Items].self, forKey: .items)
    }
    
    // Convenience initializer for tests
    init(items: [Items]) {
        self.items = items
    }
}
