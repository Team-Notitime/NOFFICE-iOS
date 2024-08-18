//
//  DebugViewController.swift
//  Noffice
//
//  Created by DOYEON LEE on 8/18/24.
//

import SwiftUI

import KeychainUtility
import UserDefaultsUtility

import PulseUI

struct DebugView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var token: String = ""
    @State private var memberId: String = ""
    @State private var memberName: String = ""
    @State private var memberProvider: String = ""
    
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
                
                // - Set member
                TextField("Enter Member ID", text: $memberId)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .keyboardType(.numberPad)
                    .frame(width: 300, height: 50)
                
                TextField("Enter Member Name", text: $memberName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .frame(width: 300, height: 50)
                
                TextField("Enter Member Provider", text: $memberProvider)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .frame(width: 300, height: 50)
                
                Button(action: {
                    setMember()
                }) {
                    Text("Set Member")
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
    
    private func setMember() {
        guard let id = Int64(memberId) else {
            print("Invalid ID")
            return
        }
        
        let member = Member(id: id, name: memberName, provider: memberProvider)
        let memberDefaultsManager = UserDefaultsManager<Member>()
        memberDefaultsManager.save(member)
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
