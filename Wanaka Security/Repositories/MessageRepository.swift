//
//  MessageRepository.swift
//  Wanaka Security
//
//  Created by Marcos Tirao on 28/06/2025.
//

import Foundation

@MainActor
protocol MessageRepositoryProtocol {
    func fetchAllMessages(token: String?) async throws -> [Message]
    func fetchAllActivity(token: String?) async throws -> [Activity]
    func fetchStatus(token: String?) async throws -> Bool
    func postAction(activity: Activity, token: String?) async throws
}


final class MessageRepositoryMock: MessageRepositoryProtocol {
    func fetchAllMessages(token: String?) async throws -> [Message] {
        return []
    }
    
    func fetchAllActivity(token: String?) async throws -> [Activity] {
        return []
    }
    
    func postAction(activity: Activity, token: String?) async throws {
    }
    
    func fetchStatus(token: String?) async throws -> Bool {
        return true
    }
}


final class MessageRepository: MessageRepositoryProtocol {
    func fetchAllMessages(token: String?) async throws -> [Message] {
        let session = URLSession.shared
        let (data, _) = try await session.data(for: ApiMessage.fetchAllMessages.asUrlRequest(token: token))
        let messageResult = try JSONDecoder().decode( [Message].self, from: data)
        return messageResult
    }
    
    func fetchAllActivity(token: String?) async throws -> [Activity] {
        let session = URLSession.shared
        let (data, _) = try await session.data(for: ApiMessage.fetchAllActivities.asUrlRequest(token: token))
        let messageResult = try JSONDecoder().decode( [Activity].self, from: data)
        return messageResult
    }
    
    func postAction(activity: Activity, token: String?) async throws {
        let session = URLSession.shared
        let (_, response) = try await session.data(for: ApiMessage.action(activity: activity).asUrlRequest(token: token))
        
        if let serverResponse = response as? HTTPURLResponse, serverResponse.statusCode > 299 {
            throw WanankaError.postActivityFailed
        }
        
    }
    
    func fetchStatus(token: String?) async throws -> Bool {
        let session = URLSession.shared
        let (_, response) = try await session.data(for: ApiMessage.fetchStatus.asUrlRequest(token: token))
        
        if let serverResponse = response as? HTTPURLResponse, serverResponse.statusCode > 299 {
            return false
        }
        return true
    }
}
