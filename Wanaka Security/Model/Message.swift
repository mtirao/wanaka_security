//
//  Message.swift
//  Wanaka Security
//
//  Created by Marcos Tirao on 28/06/2025.
//

import Foundation


protocol Element: Identifiable {
    var id: UUID { get }
    var content: String { get }
    var date: Int { get }
    var type: String { get }
}

struct Message: Codable, Element {
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
