//
//  ProfileRepository.swift
//  Wanaka Security
//
//  Created by Marcos Tirao on 16/06/2025.
//

import Foundation

@MainActor
protocol ProfileRepositoryProtocol {
    func profile(id: String, token: String?) async throws -> Profile
    func login(auth: Authentication) async throws -> JwtToken?
}

final class ProfileRepositoryMock: ProfileRepositoryProtocol {
    func profile(id: String, token: String?) async throws -> Profile {
        guard let data = MockRepository().loadJson(fileName: "Profile") else {
            let profile = Profile(cellPhone: "", email: "", firstName: "Mock", lastName: "Mock", phone: "", userRole: "user", profileId: -1, gender: "male", address: "", city: "")
            return profile
        }
        
        let profileResult = try JSONDecoder().decode(Profile.self, from: data)
        return profileResult
    }
    
    func login(auth: Authentication) async throws -> JwtToken? {
        return JwtToken(accessToken: "", tokeType: "", refreshToken: "")
    }
}


final class ProfileRepository: ProfileRepositoryProtocol {
    
    func profile(id: String, token: String?) async throws -> Profile {
        let session = URLSession.shared
        let (data, _) = try await session.data(for: ApiProfile.fetchProfile(profile: id).asUrlRequest(token: token))
        let profileResult = try JSONDecoder().decode(Profile.self, from: data)
        return profileResult
    }
    
    func login(auth: Authentication) async throws -> JwtToken? {
        
        var httRequest = try ApiProfile.login.asUrlRequest()
        
        let token = "\(auth.username):\(auth.password)"
            .data(using: .utf8)!
            .base64EncodedString()
        httRequest.addValue("Basic \(token)", forHTTPHeaderField: "authorization")
        httRequest.addValue("wanaka-security", forHTTPHeaderField: "x-client-id")
        httRequest.addValue("ae7a79e3-c2bf-43c3-a339-c27b6ed0cd39", forHTTPHeaderField: "x-client-secret")
        httRequest.addValue("api-user", forHTTPHeaderField: "x-grant-type")

        let (data, _) = try await URLSession.shared.data(for: httRequest)
        
        let profileResult = try JSONDecoder().decode(JwtToken.self, from: data)
        return profileResult
    }
    
}
