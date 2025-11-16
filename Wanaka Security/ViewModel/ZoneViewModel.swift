//
//  ZoneViewModel.swift
//  Wanaka Security
//
//  Created by Marcos Tirao on 07/11/2025.
//

import SwiftUI

@MainActor
@Observable class ZoneViewModel {
    
    var zones: [Zone] = []
  
    private let repository: any ZoneRepositoryProtocol
    
    init() {
        #if NETWORK_MOCK
        repository = ZoneRepositoryMock()
        #else
        repository = ZoneRepository()
        #endif
    }
    
    func fetchZones(token: String?) async {
        do {
            zones = try await repository.fetchAllZone(token: token)
        } catch {
            zones = []
        }
    }
    
}
