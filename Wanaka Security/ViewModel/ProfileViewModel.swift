//
//  ProfileViewModel.swift
//  Wanaka Security
//
//  Created by Marcos Tirao on 16/06/2025.
//


import SwiftUI


@MainActor
@Observable class ProfileViewModel {
    
    var isNeededAuthentication: Bool = true
    var errorText: String = " "
    var profile: Profile? = nil
    var isLoading = false
    
    private(set) var token: String?
    
    private let repository: any ProfileRepositoryProtocol
    
    init() {
        #if NETWORK_MOCK
        repository = ProfileRepositoryMock()
        #else
        repository = ProfileRepository()
        #endif
    }
    
    @discardableResult
    func validate(authentication: Authentication) -> Bool {
        guard !authentication.username.isEmpty else { return true }
        let result = authentication.username.matches(Regex.email)
        errorText = result ? "" : "Invalid email."
        return result
    }
    
    func login(authentication: Authentication) async {
        guard validate(authentication: authentication) else {
            return
        }
        guard let jwtToken = try? await repository.login(auth: authentication) else {
            errorText = "Invalid login or password"
            return
        }
        
        token = jwtToken.accessToken
        
        await fetchProfile()
        
        isNeededAuthentication = false
    }
    
    func fetchProfile() async {
        guard let token = token else {
            return
        }
        isLoading = true
        defer {
            isLoading = false
        }
        profile = try? await repository.profile(token: token)
    }
    
    
}
