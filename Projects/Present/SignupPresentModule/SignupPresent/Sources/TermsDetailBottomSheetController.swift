//
//  TermsDetailBottomSheet.swift
//  SignupPresent
//
//  Created by HUNHEE LEE on 24.12.2024.
//

import SwiftUI
import DesignSystem
import MainEntity
import Assets
import WebKit
import Router

public struct TermsDetailBottomSheet: View {
  private let termFile: TermFile
  private let onDismiss: () -> Void
  
  public init(
    termFile: TermFile,
    onDismiss: @escaping () -> Void
  ) {
    self.termFile = termFile
    self.onDismiss = onDismiss
  }
  
  public var body: some View {
    VStack(spacing: 0) {
      HStack {
        HStack {
          Spacer()
          
          Text(termFile.title)
            .font(Font.pretendard(size: 16, weight: .semibold))
            .foregroundStyle(Color.grey700)
          
          Spacer()
        }
        .frame(maxWidth: .infinity)
        .overlay(alignment: .trailing) {
          Button(action: {
            onDismiss()
          }) {
            AssetsImages(name: "icon-x").swiftUIImage
              .foregroundColor(.grey700)
            
          }
        }
      }
      .padding(.horizontal, 20)
      .padding(.vertical, 16)
      
      LocalWebView(fileName: termFile.fileName)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}

#Preview {
  TermsDetailBottomSheet(termFile: .init(
    title: "개인정보 처리방침",
    fileName: "privacy_policy"
  ), onDismiss: {
    
  })
}

public class TermsDetailBottomSheetController: BaseHostingController<TermsDetailBottomSheet> {
  public init(termFile: TermFile) {
    super.init(
      rootView: TermsDetailBottomSheet(
        termFile: termFile,
        onDismiss: {
          Router.shared.dismiss(animated: true)
        }
      )
    )
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private struct LocalWebView: UIViewRepresentable {
  let fileName: String
  
  func makeUIView(context: Context) -> WKWebView {
    let webView = WKWebView()
    webView.scrollView.bounces = false
    
    if let htmlPath = Bundle.module.path(forResource: fileName, ofType: "html") {
      let url = URL(fileURLWithPath: htmlPath)
      let request = URLRequest(url: url)
      webView.load(request)
    }
    
    return webView
  }
  
  func updateUIView(_ uiView: WKWebView, context: Context) {
  }
}
