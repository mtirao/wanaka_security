//
//  MessageModel.swift
//  Wanaka Security
//
//  Created by Marcos Tirao on 06/11/2025.
//

import Foundation
import SwiftUI

struct MessageModel: Identifiable {
    
    let id: UUID
    let content: String
    let color: Color
    
    init(message: Message) {
        self.id = message.id
        self.content = message.content
        switch(message.type) {
        case .INFO:
            color = Color.green
        case .ERROR:
            color = Color.red
        case .WARN:
            color = Color.yellow
        case .ALERT:
            color =  Color.orange
        }
    }
    
}
