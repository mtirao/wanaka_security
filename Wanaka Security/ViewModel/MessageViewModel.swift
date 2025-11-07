//
//  MessageViewModel.swift
//  Wanaka Security
//
//  Created by Marcos Tirao on 28/06/2025.
//

import SwiftUI


@MainActor
@Observable class MessageViewModel {
    
    var messages: [MessageModel] = []
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
            let messages = try await repository.fetchAllMessages(token: token)
            self.messages = messages.map{msg in MessageModel(message: msg)}
        } catch {
            messages = []
        }
    }
    
    
    func fetchActivities(token: String?) async {
        do {
            activities = try await repository.fetchAllActivity(token: token)
            if let firstActivity = activities.first, ["STAY", "AWAY", "CUSTOM"].contains(firstActivity.content)  {
                systemArmed = true
            } else {
                systemArmed = false
            }
        } catch {
            activities = []
        }
    }
    
    func postActivity(activity: Activity, token: String?) async {
        do {
            try await repository.postAction(activity: activity, token: token)
            systemArmed = true
        } catch {
            systemArmed = false
        }
    }
}
