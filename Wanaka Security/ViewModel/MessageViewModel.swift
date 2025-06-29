//
//  MessageViewModel.swift
//  Wanaka Security
//
//  Created by Marcos Tirao on 28/06/2025.
//

import SwiftUI


@MainActor
@Observable class MessageViewModel {
    
    var messages: [Message] = []
    var activities: [Activity] = []
    
    private let repository: any MessageRepositoryProtocol
    
    init() {
        #if NETWORK_MOCK
        repository = MessageeRepositoryMock()
        #else
        repository = MessageRepository()
        #endif
    }
    
    func fetchMessages(token: String?) async {
        do {
            messages = try await repository.fetchAllMessages(token: token)
        } catch {
            messages = []
        }
    }
    
    func fetchActivities(token: String?) async {
        do {
            activities = try await repository.fetchAllActivity(token: token)
        } catch {
            activities = []
        }
    }
    
}
