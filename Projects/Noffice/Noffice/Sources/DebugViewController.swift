//
//  DebugViewController.swift
//  Noffice
//
//  Created by DOYEON LEE on 8/18/24.
//

import SwiftUI

import KeychainUtility

import PulseUI

struct DebugView: View {
    @Environment(\.dismiss) var dismiss
    @State private var token: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                // - Move Console button
                NavigationLink(destination: ConsoleView()) {
                    Text("Open Pulse Console")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
                
                // - Set token
                TextField("Enter Access Token", text: $token)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .frame(width: 300, height: 50)
                
                Button(action: {
                    setAccessToken()
                }) {
                    Text("Set Access Token")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
                
                // - Close button
                Button(action: {
                    dismiss()
                }) {
                    Text("Close")
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                Spacer()
            }
            .background(Color.white)
            .ignoresSafeArea(edges: .all) // 전체 화면 배경색 지정
        }
    }
    
    private func setAccessToken() {
        let tokenKeychainManager = KeychainManager<Token>()
        let token = Token(
            accessToken: self.token,
            refreshToken: ""
        )
        tokenKeychainManager.save(token)
    }
    
    private func getToken() {
        let tokenKeychainManager = KeychainManager<Token>()
        
    }
}

struct DebugView_Previews: PreviewProvider {
    static var previews: some View {
        DebugView()
    }
}
