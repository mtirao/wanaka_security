//
//  Settings.swift
//  Wanaka Security
//
//  Created by Marcos Tirao on 28/06/2025.
//

import SwiftUI

struct User: View {
    @Environment(ProfileViewModel.self) private var profile
    
    
    var body: some View {
        VStack {
            VStack {
                ZStack {
                    Circle()
                        .fill(Color.indigo)
                        .frame(width: 70, height: 70) // Adjust size as needed
                    Text(String(profile.profile?.firstName.first ?? "U").uppercased())
                        .foregroundColor(.white)
                        .font(.system(size: 30, weight: .bold)) // Customize font
                }
                Text((profile.profile?.lastName ?? "") + " " + (profile.profile?.firstName ?? ""))
                    .font(.system(size: 20, weight: .bold))
                Text(profile.profile?.email ?? "")
                    .font(.system(size: 15))
            }.padding(32)
            
            List {
                section(profile.profile?.address ?? "Undisclosed", "Address")
                    .padding(4)
                section(profile.profile?.cellPhone ?? "Undisclosed", "Mobile")
                    .padding(4)
                section(profile.profile?.phone ?? "Undisclosed", "Phone")
                    .padding(4)
                section(profile.profile?.city ?? "Undisclosed", "City")
                    .padding(4)
                section(profile.profile?.gender ?? "Undisclosed", "Gender")
                    .padding(4)
            }.listStyle(.plain)
        }.task {
            await profile.fetchProfile()
        }
        
    }
    
    @ViewBuilder
    private func section(_ title: String, _ name: String) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                Text(name)
                    .font(.caption)
            }
        }
    }
}

#Preview {
    User()
}
