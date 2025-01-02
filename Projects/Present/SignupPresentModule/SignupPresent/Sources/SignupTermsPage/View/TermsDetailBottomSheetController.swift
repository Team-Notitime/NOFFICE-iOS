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
import RxSwift

public struct TermsDetailBottomSheet: View {
  private let termFile: TermFile
  @ObservedObject private var reactor: SignupTermsDetailContainer
  
  public init(
    termFile: TermFile,
    reactor: SignupTermsDetailContainer
  ) {
    self.termFile = termFile
    self.reactor = reactor
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
            reactor.dismiss()
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

public class TermsDetailBottomSheetController: BaseHostingController<TermsDetailBottomSheet> {
  private let reactor: SignupTermsPageReactor
  private let disposeBag = DisposeBag()
  
  public init(
    termFile: TermFile,
    reactor: SignupTermsPageReactor
  ) {
    self.reactor = reactor
    let rootView = TermsDetailBottomSheet(
      termFile: termFile,
      reactor: .init(reactor: reactor)
    )
    
    super.init(rootView: rootView)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public override func setupStateBind() {
    reactor.state.map(\.termsDetailVisible)
      .filter { $0 == false }
      .subscribe { _ in
        self.dismiss(animated: true)
      }
      .disposed(by: disposeBag)
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
