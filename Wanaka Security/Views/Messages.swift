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
            ActivitiesCells()
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
            ForEach(messageViewModel.messages) { cell in
                VStack(alignment: .leading) {
                    Text(cell.content)
                        .font(.headline)
                    Text(cell.type)
                        .font(.caption)
                }
            }
        }
    }
    
    @ViewBuilder
    func ActivitiesCells() -> some View {
        Section("Activities", isExpanded: $isActivitiesExpanded) {
            ForEach(messageViewModel.activities) { cell in
                VStack {
                    HStack {
                        Text(cell.content)
                            .font(.headline)
                        Spacer()
                    }
                }
            }
        }
    }
    
}

#Preview {
    Messages()
}
