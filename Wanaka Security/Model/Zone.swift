//
//  Zone.swift
//  Wanaka Security
//
//  Created by Marcos Tirao on 07/11/2025.
//

import Foundation


enum ZoneType: String, Codable {
    case Enabled = "ENABLED"
    case Disabled = "DISABLED"
    
}

struct Zone: Codable {
    let id: UUID
    let name: String
    let state: ZoneType
}
