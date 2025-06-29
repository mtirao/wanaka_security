//
//  ApiMessage.swift
//  Wanaka Security
//
//  Created by Marcos Tirao on 28/06/2025.
//

import Foundation

enum ApiMessage: Api {
    
    case fetchAllMessages
    case fetchAllActivities
    
    var server: String {
        return "http://localhost:3000"
    }
    
    var path: String {
        switch self {
        case .fetchAllMessages:
            return "/api/wanaka/message"
        case .fetchAllActivities:
            return "/api/wanaka/activity"
        }
    }
    
    var method: String {
        switch self {
        case .fetchAllMessages:
            return "GET"
        case .fetchAllActivities:
            return "GET"
        }
    }
    
    var body: Data? {
        return nil as Data?
    }
}
