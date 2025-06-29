//
//  ContentView.swift
//  Wanaka Security
//
//  Created by Marcos Tirao on 16/06/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
   
    @State private var profile = ProfileViewModel()
    
    var body: some View {
        
#if os(iOS)
        if profile.isNeededAuthentication {
           LoginView()
                .environment(profile)
        }else {
            iOSMainView()
                .environment(profile)
        }
#else
        if profile.isNeededAuthentication {
            Rectangle()
                .sheet(isPresented: $profile.isNeededAuthentication) {
                    LoginView()
                        .environment(profile)
                }
        }else {
            MacOSMainView()
        }
#endif
        
    }
}

