//
//  MainView.swift
//  Wanaka Security
//
//  Created by Marcos Tirao on 28/06/2025.
//

import SwiftUI

struct MainView: View {
    
    @Environment(ProfileViewModel.self) private var profile
    
    var body: some View {
        VStack(spacing:32) {
            Spacer()
            Button(action: {}) {
                VStack {
                    Image("launchScreen")
                        .resizable()
                        .frame(width: 128, height: 128)
                    Text("Ready to Arm")
                }
            }
            
            HStack(spacing: 16) {
                Spacer()
                Button(action: {}) {
                    VStack {
                        Image("launchScreen")
                            .resizable()
                            .frame(width: 64, height: 64)
                        Text("Arm Stay")
                    }
                }
                
                Button(action: {}) {
                    VStack {
                        Image("launchScreen")
                            .resizable()
                            .frame(width: 64, height: 64)
                        Text("Arm Away")
                    }
                }
                
                
                Button(action: {}) {
                    VStack {
                        Image("launchScreen")
                            .resizable()
                            .frame(width: 64, height: 64)
                        Text("Arm Custom")
                    }
                }
                Spacer()
            }
            Spacer()
        }
        .cornerRadius(16)
        .background(Color.gray.opacity(0.1))
    }
}

#Preview {
    MainView()
}
