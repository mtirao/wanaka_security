//
//  Config.swift
//  Wanaka Security
//
//  Created by Marcos Tirao on 07/11/2025.
//

import SwiftUI

struct ZoneView: View {
    
    @Environment(ProfileViewModel.self) private var profile
    
    @State var zoneViewModel: ZoneViewModel = .init()
    
    @State private var router = ZoneViewRouter()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            List {
                ForEach(zoneViewModel.zones) { zone in
                    NavigationLink(destination: zoneView(id: zone.id)) {
                        Text(zone.name)
                            .font(.headline)
                            .foregroundStyle(Color.black)
                    }
                }
            }
            .navigationTitle("Zones")
            .navigationBarTitleDisplayMode(.large)
            .navigationDestination(for: Route.self) { route in router.view(for: route) }
            .listStyle(.plain)
            .background(RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
            )
            .task {
                await zoneViewModel.fetchZones(token: profile.token)
            }
        }
    }
    
    @ViewBuilder
    func zoneView(id: UUID) -> some View {
        VStack {
            HStack {
                Text("Status")
                Spacer()
                Text("Active")
            }.font(.headline)
            HStack {
                Text("Type")
                Spacer()
                Text("DOOR")
            }
            HStack {
                Text("Location")
                Spacer()
                Text("Bedrrom")
            }
        }.padding(16)
    }
    
}

#Preview {
    ZoneView()
}
