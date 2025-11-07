//
//  MainView.swift
//  Wanaka Security
//
//  Created by Marcos Tirao on 28/06/2025.
//

import SwiftUI

enum SystemArmmingType: String {
    case stay = "STAY"
    case away = "AWAY"
    case custom = "CUSTOM"
    case disarm = "DISARMED"
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
            .background(RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
            )
            .compositingGroup()
            .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 10, y: 10) // << shadow to all composition

            
            VStack(spacing:32) {
                HStack(spacing:32) {
                    WanakaButton(title: "Arm Stay") {
                        systemArm(type: .stay)
                    }
                    WanakaButton(title: "Arm Away") {
                        systemArm(type: .away)
                    }
                }
                HStack(spacing:32) {
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
                }.padding(.top, 16)
                List {
                    ForEach(messageViewModel.messages) { message in
                        HStack {
                            Image(systemName: "info.circle.fill")
                                .renderingMode(.template)
                                .resizable()
                                .tint(message.color)
                                .foregroundStyle(message.color)
                                .frame(width:20, height: 20)
                            Text(message.content)
                                .font(.caption)
                                .foregroundStyle(Color.black)
                                
                        }
                        .listRowSeparator(.hidden)
                    }
                }
                .listStyle(.plain)
            }.background(RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
            )
            .compositingGroup()
            .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 10, y: 10) // << shadow to all composition
            
            Spacer()
        }
        .padding(16)
        .task {
            await messageViewModel.fetchMessages(token: profile.token)
            await messageViewModel.fetchActivities(token: profile.token)
        }
        .background(.white)
    }
    
    private func systemArm(type: SystemArmmingType) {
        Task {
            let activity = Activity(
                id: UUID(),
                content: type.rawValue,
                date: Int(Date().timeIntervalSince1970))
            await messageViewModel.postActivity(activity: activity, token: profile.token)
        }
    }
}

#Preview {
    MainView()
}
