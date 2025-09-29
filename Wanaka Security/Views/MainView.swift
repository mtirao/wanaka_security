//
//  MainView.swift
//  Wanaka Security
//
//  Created by Marcos Tirao on 28/06/2025.
//

import SwiftUI

enum SystemArmmingType: String {
    case stay = "ArmedStay"
    case away = "ArmedAway"
    case custom = "ArmedCustome"
    case disarm = "Disarmed"
}

struct MainView: View {
    
    @Environment(ProfileViewModel.self) private var profile
    
    @State private var messageViewModel = MessageViewModel()
    
    var body: some View {
        VStack(spacing:32) {
            VStack(spacing:16) {
                HStack {
                    Text("Wanaka Security Dashboard")
                        .font(.headline)
                    Spacer()
                }
                HStack {
                    if messageViewModel.systemArmed {
                        Text("Current status: Armed." )
                            .font(.callout)
                            .foregroundColor(.gray)
                    } else {
                        Text("Current status: Disarmed." )
                            .font(.callout)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                }
            }
            .padding(16)
            .background(.gray.opacity(0.1))
            .cornerRadius(16)
            
            VStack {
                HStack {
                    WanakaButton(title: "Arm Stay") {
                        systemArm(type: .stay)
                    }
                    WanakaButton(title: "Arm Away") {
                        systemArm(type: .away)
                    }
                }
                HStack {
                    WanakaButton(title: "Arm Custom") {
                        systemArm(type: .custom)
                    }
                    WanakaButton(title: "Disarm") {
                        systemArm(type: .disarm)
                    }
                }
            }
            
            VStack {
                HStack {
                    Text("Recent Alerts")
                        .font(.headline)
                        .padding(.leading, 16)
                    Spacer()
                }
                List {
                    ForEach(messageViewModel.activities) { activity in
                        HStack {
                            Image(systemName: "info.circle.fill")
                                .renderingMode(.template)
                                .resizable()
                                .tint(Color.accent)
                                .foregroundStyle(Color.accent)
                                .frame(width:20, height: 20)
                            Text(activity.content)
                                .font(.caption)
                                .foregroundStyle(Color.black)
                                
                        }
                    }
                }.listStyle(.plain)
            }
            .cornerRadius(16)
            
            Spacer()
        }
        .padding(16)
        .task {
            await messageViewModel.fetchStatus(token: profile.token)
            await messageViewModel.fetchActivities(token: profile.token)
        }
        .background(.white)
    }
    
    private func systemArm(type: SystemArmmingType) {
        guard let profileId = profile.profile?.profileId else {
            return
        }
        Task {
            let activity = Activity(
                id: UUID(),
                content: type.rawValue,
                date: Int(Date().timeIntervalSince1970),
                userId:  profileId)
            await messageViewModel.postActivity(activity: activity, token: profile.token)
        }
    }
}

#Preview {
    MainView()
}
