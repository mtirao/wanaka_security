//
//  Message.swift
//  Wanaka Security
//
//  Created by Marcos Tirao on 28/06/2025.
//

import Foundation


struct Message: Codable, Identifiable {
    let id: UUID
    let content: String
    let date: Int
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case content = "messageContent"
        case date = "messageDate"
        case id = "messageId"
        case type = "messageType"
    }
}
