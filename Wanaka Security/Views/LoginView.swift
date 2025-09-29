//
//  LoginView.swift
//  Wanaka Security
//
//  Created by Marcos Tirao on 16/06/2025.
//

import SwiftUI


struct LoginView: View {
    
    @Environment(ProfileViewModel.self) private var profile
    
    @State private var login = ""
    @State private var password = ""
    
    @FocusState private var isLoginFocused: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Text("SmartList Login")
                .font(.largeTitle).foregroundColor(Color.accentColor)
                .padding([.top, .bottom], 40)
            
            VStack(alignment: .leading, spacing: 15) {
                TextField("Email", text: $login)
                    .focused($isLoginFocused)
                
                    .onChange(of: isLoginFocused) {value, newValue in
                        let auth = Authentication(username:login, password: password)
                        profile.validate(authentication: auth)
                    }
                    #if os(macOS)
                    .textFieldStyle(.plain)
                    #endif
                    .textContentType(.emailAddress)
                    #if os(iOS)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    #endif
                    .padding()
                    .cornerRadius(20.0)
                    .overlay( RoundedRectangle(cornerRadius: 20) .stroke(Color.accentColor) )
                
                SecureField("Password", text: $password)
                    .textFieldStyle(.plain)
                    .padding()
                    .cornerRadius(20.0)
                    .overlay( RoundedRectangle(cornerRadius: 20) .stroke(Color.accentColor) )
            }.padding([.leading, .trailing], 27.5)
            
            Text(profile.errorText)
                .font(.subheadline).foregroundColor(Color.red)
            
            if profile.isLoading {
                ProgressView()
            }
            
            
            WanakaButton(title: "Sign In") {
                Task {
                    let auth = Authentication(username: login, password: password)
                    await profile.login(authentication: auth)
                }
            }.frame(width: 200)
            
            HStack(spacing: 0) {
                Text("Don't have an account? ")
                Button(action: {}) {
                    Text("Sign Up")
                        .foregroundColor(.black)
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
