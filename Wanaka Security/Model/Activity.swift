//
//  Activity.swift
//  Wanaka Security
//
//  Created by Marcos Tirao on 28/06/2025.
//

import Foundation

struct Activity: Codable, Identifiable {
    var id: UUID
    let content: String
    let date: Int
    let userId: UUID
    
    enum CodingKeys: String, CodingKey {
        case content = "activityContent"
        case date = "activityDate"
        case id = "activityId"
        case userId = "activityUserId"
    }
}
