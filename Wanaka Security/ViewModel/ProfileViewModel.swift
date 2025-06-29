import SwiftUI


@MainActor
@Observable class ProfileViewModel {
    
    var isNeededAuthentication: Bool = false
    var errorText: String = " "
    var profile: Profile? = nil
    var isLoading = false
    var token: String?
    
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
        
        isNeededAuthentication = false
    }
}
