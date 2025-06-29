//
//  iOSMainView.swift
//  Wanaka Security
//
//  Created by Marcos Tirao on 22/06/2025.
//

import SwiftUI

struct iOSMainView: View {
    
    @Environment(ProfileViewModel.self) private var profile
    
    var body: some View {
        TabView {
            MainView()
                .environment(profile)
                .tabItem{
                    Label("Home", systemImage: "house")
                }
            Messages()
                .environment(profile)
                .tabItem{
                    Label("Messages", systemImage: "message")
                }
            Settings()
                .tabItem{
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

#Preview {
    iOSMainView()
}
