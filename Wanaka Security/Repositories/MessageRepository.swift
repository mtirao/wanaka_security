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
}


final class MessageRepositoryMock: MessageRepositoryProtocol {
    func fetchAllMessages(token: String?) async throws -> [Message] {
        return []
    }
    
    func fetchAllActivity(token: String?) async throws -> [Activity] {
        return []
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
}
