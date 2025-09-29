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
    var systemArmed: Bool = false
    
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
    
    func fetchStatus(token: String?) async {
        do {
            systemArmed = try await repository.fetchStatus(token: token)
        } catch {
            systemArmed = false
        }
    }
    
    func fetchActivities(token: String?) async {
        do {
            activities = try await repository.fetchAllActivity(token: token)
        } catch {
            activities = []
        }
    }
    
    func postActivity(activity: Activity, token: String?) async {
        do {
            try await repository.postAction(activity: activity, token: token)
            systemArmed = try await repository.fetchStatus(token: token)
        } catch {
            systemArmed = false
        }
    }
}
