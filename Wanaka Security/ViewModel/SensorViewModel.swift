//
//  SensorViewModel.swift
//  Wanaka Security
//
//  Created by Marcos Tirao on 16/11/2025.
//

import SwiftUI

@MainActor
@Observable class SensorViewModel {
    var sensors: [Sensor] = []
    
    private let repository: any SensorRepositoryProtocol
    
    
    init() {
        #if NETWORK_MOCK
        repository = SensorRepositoryMock()
        #else
        repository = SensorRepository()
        #endif
    }
    
    func fetchSensors(token: String?, zone: UUID) async {
        do {
            sensors = try await repository.fetchAllSensor(token: token, zone: zone)
        } catch {
            sensors = []
        }
    }
    
}
