//
//  ZoneRouter.swift
//  Wanaka Security
//
//  Created by Marcos Tirao on 10/11/2025.
//


import Foundation
import SwiftUI

@Observable
class ZoneViewRouter : ViewRouter {
    
    // Builds the views
    @MainActor
    @ViewBuilder func view(for route: Route) -> some View {
        switch route {
        case .sensor(let sensor):
            EmptyView()
        default:
            EmptyView()
        }
    }
}
