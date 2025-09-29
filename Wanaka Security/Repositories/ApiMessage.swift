//
//  ApiMessage.swift
//  Wanaka Security
//
//  Created by Marcos Tirao on 28/06/2025.
//

import Foundation

enum WanankaError: Error {
    case postActivityFailed
}

enum ApiMessage: Api {
    
    case fetchAllMessages
    case fetchAllActivities
    case fetchStatus
    case action(activity: Activity)
    
    var server: String {
        return "http://localhost:3000"
    }
    
    var path: String {
        switch self {
        case .fetchAllMessages:
            return "/api/wanaka/message"
        case .fetchAllActivities:
            return "/api/wanaka/activity"
        case .fetchStatus:
            return "/api/wanaka/status"
        case .action:
            return "/api/wanaka/activity"
        }
    }
    
    var method: String {
        switch self {
        case .fetchAllMessages:
            return "GET"
        case .fetchAllActivities:
            return "GET"
        case .fetchStatus:
            return "GET"
        case .action:
            return "POST"
        }
    }
    
    var body: Data? {
        switch self {
        case .action(let body):
            return createBody(body)
        default:
            return nil
        }
    }
    
    private func createBody<T: Encodable>(_ body: T) -> Data? {
        let jsonBody = try? JSONEncoder().encode(body)
        print(String(data: jsonBody!, encoding: .utf8) ?? "")
        return jsonBody
    }
}
