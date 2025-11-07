//
//  Message.swift
//  Wanaka Security
//
//  Created by Marcos Tirao on 28/06/2025.
//

import Foundation

enum MessageType: String, Codable {
    case INFO = "INFO"
    case ERROR = "ERROR"
    case WARN = "WARN"
    case ALERT = "ALERT"
}

struct Message: Codable, Identifiable {
    let id: UUID
    let content: String
    let date: Int
    let type: MessageType
    
    enum CodingKeys: String, CodingKey {
        case content = "messageContent"
        case date = "messageDate"
        case id = "messageId"
        case type = "messageType"
    }
}
