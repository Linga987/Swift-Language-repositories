//
//  Items.swift
//  iOSAssignment
//
//  Created by Lingaswami Karingula on 01/09/25.
//

import Foundation
struct Items : Codable {
    let id : Int?
    let name : String?
    let html_url : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case name = "name"
        case html_url = "html_url"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        html_url = try values.decodeIfPresent(String.self, forKey: .html_url)
    }
    
    // Convenience initializer for tests
    init(id: Int, name: String, html_url: String) {
        self.id = id
        self.name = name
        self.html_url = html_url
    }
}
