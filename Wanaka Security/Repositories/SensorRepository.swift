//
//  SensorRepository.swift
//  Wanaka Security
//
//  Created by Marcos Tirao on 16/11/2025.
//
import Foundation

@MainActor
protocol SensorRepositoryProtocol {
    func fetchAllSensor(token: String?, zone: UUID) async throws -> [Sensor]
}


final class SensorRepositoryMock: SensorRepositoryProtocol {
    func fetchAllSensor(token: String? = nil, zone: UUID) async throws -> [Sensor] {
        return []
    }
}


final class SensorRepository: SensorRepositoryProtocol {
    
    func fetchAllSensor(token: String?, zone: UUID) async throws -> [Sensor] {
        let session = URLSession.shared
        let (data, _) = try await session.data(for: ApiSensor.fetchAllZoneSensors(zone: zone).asUrlRequest(token: token))
        let sensorResult = try JSONDecoder().decode( [Sensor].self, from: data)
        return sensorResult
    }
    
    
}
