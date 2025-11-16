//
//  ZoneRepository.swift
//  Wanaka Security
//
//  Created by Marcos Tirao on 07/11/2025.
//

import Foundation


@MainActor
protocol ZoneRepositoryProtocol {
    func fetchAllZone(token: String?) async throws -> [Zone]
}


final class ZoneRepositoryMock: ZoneRepositoryProtocol {
    func fetchAllZone(token: String? = nil) async throws -> [Zone] {
        return []
    }
}


final class ZoneRepository: ZoneRepositoryProtocol {
    func fetchAllZone(token: String? = nil) async throws -> [Zone] {
        let session = URLSession.shared
        let (data, _) = try await session.data(for: ApiZone.fetchAllZone.asUrlRequest(token: token))
        let zoneResult = try JSONDecoder().decode( [Zone].self, from: data)
        return zoneResult
    }
}
