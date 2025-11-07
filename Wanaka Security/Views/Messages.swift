//
//  Messages.swift
//  Wanaka Security
//
//  Created by Marcos Tirao on 28/06/2025.
//

import SwiftUI

struct Messages: View {
    
    @State private var messageViewModel = MessageViewModel()
    
    @State private var isMesagesExpanded: Bool = false
    @State private var isActivitiesExpanded: Bool = false
    
    @Environment(ProfileViewModel.self) private var profile
    
    var body: some View {
        List {
            MessagesCells()
        }.listStyle(.grouped)
        .task {
            await messageViewModel.fetchMessages(token: profile.token)
            await messageViewModel.fetchActivities(token: profile.token)
            isMesagesExpanded = !messageViewModel.messages.isEmpty
            isActivitiesExpanded = !messageViewModel.activities.isEmpty
        }
    }
    
    @ViewBuilder
    func MessagesCells() -> some View {
        
        Section("Messages", isExpanded: $isMesagesExpanded) {
            List {
                ForEach(messageViewModel.messages) { cell in
                    HStack {
                        Image(systemName: "info.circle.fill")
                            .renderingMode(.template)
                            .resizable()
                            .tint(cell.color)
                            .foregroundStyle(cell.color)
                            .frame(width:20, height: 20)
                        Text(cell.content)
                            .font(.caption)
                            .foregroundStyle(Color.black)
                            
                    }
                }
            }
        }
    }
    
}

#Preview {
    Messages()
}
