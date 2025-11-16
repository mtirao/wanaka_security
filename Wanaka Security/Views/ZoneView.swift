//
//  Config.swift
//  Wanaka Security
//
//  Created by Marcos Tirao on 07/11/2025.
//

import SwiftUI

struct Zone: View {
    
    @Environment(ProfileViewModel.self) private var profile
    
    @State var zoneViewModel: ZoneViewModel = .init()
    
    @State private var router = ZoneViewRouter()
    
    var body: some View {
        List {
            ForEach(zoneViewModel.zones) { zone in
                Text(zone.name)
                    .font(.headline)
                    .foregroundStyle(Color.black)
            }
        }.listStyle(.plain)
        .background(RoundedRectangle(cornerRadius: 10)
            .fill(Color.white)
        )
        .task {
            await zoneViewModel.fetchZones(token: profile.token)
        }
    }
    
}

#Preview {
    Config()
}
