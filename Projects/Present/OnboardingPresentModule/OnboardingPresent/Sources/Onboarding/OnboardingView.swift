//
//  OnboardingView.swift
//  OnboardingPresent
//
//  Created by HUNHEE LEE on 22.12.2024.
//

import SwiftUI
import Assets
import DesignSystem

public struct OnboardingView: View {
  @StateObject private var container: OnboardingStateContainer
  
  public var body: some View {
    VStack(spacing: 0) {
      PageIndicators(pages: container.pages, currentPage: container.currentPage)
      
      ZStack {
        OnboardingPageView(
          pages: container.pages,
          currentPage: container.currentPage,
          pageChanged: container.pageChanged
        )
        
        BottomButton(
          title: container.buttonTitle,
          action: {
            withAnimation {
              container.nextButtonTapped()
            }
          }
        )
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.grey900)
  }
  
  public init(reactor: OnboardingReactor) {
    let container = OnboardingStateContainer(reactor: reactor)
    _container = StateObject(wrappedValue: container)
  }
}

private struct PageIndicators: View {
  let pages: [OnboardingPage]
  let currentPage: Int
  
  var body: some View {
    HStack(spacing: 8) {
      ForEach(pages) { page in
        Circle()
          .frame(width: 6, height: 6)
          .foregroundStyle(page.id == currentPage ? Color.green500 : Color.grey600)
      }
      
      Spacer()
    }
    .padding(.top, 52)
    .padding(.leading, 34)
  }
}

private struct OnboardingPageView: View {
  let pages: [OnboardingPage]
  let currentPage: Int
  let pageChanged: (Int) -> Void
  
  var body: some View {
    TabView(selection: Binding(
      get: { currentPage },
      set: { pageChanged($0) }
    )) {
      ForEach(pages) { page in
        PageContent(page: page)
          .tag(page.id)
      }
    }
    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
  }
}

private struct PageContent: View {
  let page: OnboardingPage
  
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      OnboardingTextGuide(title: page.title, content: page.content)
      OnboardingImageGuide(imageName: page.imageName)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
  }
}

private struct OnboardingTextGuide: View {
  let title: String
  let content: String
  
  var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text(title)
        .font(Font.pretendard(size: 22, weight: .semibold))
        .lineSpacing(28.6 - 22)
        .foregroundStyle(Color.fullWhite)
      
      Text(content)
        .font(Font.pretendard(size: 14, weight: .regular))
        .lineSpacing(19.6 - 14)
        .foregroundStyle(Color.fullWhite)
      
      Spacer()
    }
    .frame(maxHeight: 142)
    .padding(.vertical, 16)
    .padding(.horizontal, 30)
  }
}

private struct OnboardingImageGuide: View {
  let imageName: String
  
  var body: some View {
    GeometryReader { geometry in
      Image(asset: AssetsImages(name: imageName))
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(width: geometry.size.width - 36.5)
        .frame(height: geometry.size.height - 3, alignment: .top)
        .clipped()
        .padding(.horizontal, 18.25)
        .padding(.bottom, 3)
    }
  }
}

private struct BottomButton: View {
  let title: String
  let action: () -> Void
  
  var body: some View {
    VStack {
      Spacer()
      
      Button(title) {
        withAnimation {
          action()
        }
      }
      .buttonStyle(BasicButtonStyle(variant: .fill, color: .green))
      .padding(.horizontal, 16)
    }
  }
}

enum BasicButtonVariant {
  case fill
  case outline
}

enum BasicButtonColor {
  case blue
  case green
  case gray
  
  var mainColor: Color {
    switch self {
    case .blue: return Color.blue
    case .green: return Color.green
    case .gray: return Color.gray
    }
  }
  
  var textColor: Color {
    switch self {
    case .gray: return .black
    default: return .white
    }
  }
}

// MARK: - Button Style
struct BasicButtonStyle: ButtonStyle {
  let variant: BasicButtonVariant
  let color: BasicButtonColor
  var font: Font = Font.pretendard(size: 18, weight: .semibold)
  var height: CGFloat = 54
  var cornerRadius: CGFloat = 8
  
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .font(font)
      .frame(maxWidth: .infinity, maxHeight: height)
      .background(
        Group {
          switch variant {
          case .fill:
            color.mainColor
          case .outline:
            Color.clear
          }
        }
      )
      .foregroundColor(variant == .fill ? color.textColor : color.mainColor)
      .cornerRadius(cornerRadius)
      .overlay(
        RoundedRectangle(cornerRadius: cornerRadius)
          .stroke(color.mainColor, lineWidth: variant == .outline ? 1 : 0)
      )
      .brightness(configuration.isPressed ? -0.05 : 0)
      .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
      .animation(.spring(response: 0.2, dampingFraction: 0.7), value: configuration.isPressed)
      .buttonStyle(PlainButtonStyle())
  }
}
