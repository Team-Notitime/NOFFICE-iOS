//
//  DebugViewController.swift
//  Noffice
//
//  Created by DOYEON LEE on 8/18/24.
//

import SwiftUI

import PulseUI

struct DebugView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                // - Move Console button
                NavigationLink(destination: ConsoleView()) {
                    Text("Open Pulse Console")
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
                
                // - Close button
                Button(action: {
                    dismiss()
                }) {
                    Text("Close")
                        .frame(width: 100, height: 50)
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
}

struct DebugView_Previews: PreviewProvider {
    static var previews: some View {
        DebugView()
    }
}
