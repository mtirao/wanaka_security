//
//  ApiProfile.swift
//  Wanaka Security
//
//  Created by Marcos Tirao on 22/06/2025.
//


//
//  ApiProfile.swift
//  SmartList
//
//  Created by Marcos Tirao on 03/09/2024.
//

import Foundation

enum ApiProfile: Api {
    
    case fetchProfile(profile: String)
    case login
    
    var server: String {
        return "http://localhost:3000"
    }
    
    var path: String {
        switch self {
        case .fetchProfile(let profile):
            return "/api/wanaka/profile/\(profile)"
        case .login:
            return "/api/wanaka/accounts/login"
        }
    }
    
    var method: String {
        switch self {
        case .fetchProfile:
            return "GET"
        case .login:
            return "POST"
        }
    }
    
    var body: Data? {
        switch self {
        case .login:
            return nil as Data?
        default:
            return nil as Data?
        }
    }
}
