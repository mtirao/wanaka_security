//
//  ApiZone.swift
//  Wanaka Security
//
//  Created by Marcos Tirao on 07/11/2025.
//

import Foundation

enum ApiZone: Api {
    
    case fetchAllZone

    var server: String {
        return "http://localhost:3000"
    }
    
    var method: String {
        switch self {
        case .fetchAllZone:
            return "GET"
        }
    }
    
    
    var path: String {
        switch self {
        case .fetchAllZone:
            return "/api/wanaka/zone"
        }
    }
    
    var body: Data? {
        switch self {
        case .fetchAllZone:
            return nil
        }
    }
    
}
