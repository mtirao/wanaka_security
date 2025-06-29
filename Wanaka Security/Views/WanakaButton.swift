//
//  WanakaButton.swift
//  Wanaka Security
//
//  Created by Marcos Tirao on 16/06/2025.
//

import SwiftUI

struct WanakaButton: View {
    
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 200, height: 50)
                .background(Color.accentColor)
                .cornerRadius(15.0)
        }
        .buttonStyle(.plain)
    }
}
