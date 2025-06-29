//
//  Message.swift
//  Wanaka Security
//
//  Created by Marcos Tirao on 28/06/2025.
//

import Foundation

struct Message: Codable, Identifiable {
    let id: UUID
    let messageContent: String
    let messageDate: Int
    let messageType: String
    
    enum CodingKeys: String, CodingKey {
        case messageContent = "messageContent"
        case messageDate = "messageDate"
        case id = "messageId"
        case messageType = "messageType"
    }
}
