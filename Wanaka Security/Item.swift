//
//  Item.swift
//  Wanaka Security
//
//  Created by Marcos Tirao on 16/06/2025.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
