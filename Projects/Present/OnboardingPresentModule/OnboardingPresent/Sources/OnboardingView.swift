//
//  OnboardingView.swift
//  OnboardingPresent
//
//  Created by HUNHEE LEE on 22.12.2024.
//

import SwiftUI

public struct OnboardingView: View {
  @StateObject private var container: OnboardingStateContainer
  
  private let pages: [OnboardingPage] = [
    OnboardingPage(
      id: 0,
      title: "일일히 작성해서\n귀찮았던 공지는 그만!",
      content: "줄 나누기, 이모지, 더 이상 필요없어요!\n내가 원하는 내용만 담아서 가독성 좋게 전달할 수 있어요"
    ),
    OnboardingPage(
      id: 1,
      title: "안 읽어서 답답했던\n단체생활 공지는 이제 안녕!",
      content: "읽은 사람과 안 읽은 사람을 한 눈에 볼 수 있어요"
    ),
    OnboardingPage(
      id: 2,
      title: "동아리, 스터디, 소모임\n어떤 단체든 알차게 활용해요",
      content: "리더에게는 더욱 편리한 공지 발행 과정을,\n멤버에게는 복잡하지 않은 공지를 선물할게요"
    )
  ]
  
  public var body: some View {
    VStack(spacing: 0) {
      VStack(spacing: 0) {
        HStack(spacing: 8) {
          ForEach(container.pages) { page in
            Circle()
              .frame(width: 6, height: 6)
              .foregroundStyle(page.id == container.currentPage ? Color.green500 : Color.grey600)
          }
          
          Spacer()
        }
        .padding(.top, 52)
        .padding(.leading, 34)
        .padding(.bottom, 16)
        
        ZStack {
          TabView(selection: Binding(
            get: { container.currentPage },
            set: { container.pageChanged($0) }
          )) {
            ForEach(container.pages) { page in
              VStack(alignment: .leading, spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                  Text(page.title)
                    .font(Font.pretendard(size: 22, weight: .semibold))
                    .lineSpacing(28.6 - 22)
                    .foregroundStyle(Color.fullWhite)
                    .padding(.bottom, 16)
                  
                  Text(page.content)
                    .font(Font.pretendard(size: 14, weight: .regular))
                    .lineSpacing(19.6 - 14)
                    .foregroundStyle(Color.fullWhite)
                  
                  Spacer()
                }
                .frame(maxHeight: 142)
                .padding(.bottom, 20)
                
                ZStack {
                  Color.fullWhite
                    .clipShape(RoundedRectangle(cornerRadius: 33.6))
                    .overlay(
                      RoundedRectangle(cornerRadius: 33.6)
                        .stroke(Color.grey800, lineWidth: 11.75)
                    )
                }
                
                Spacer()
              }
              .padding(.horizontal, 30)
              .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            }
          }
          .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
          
          VStack {
            Spacer()
            
            Button(container.buttonTitle) {
              withAnimation {
                container.nextButtonTapped()
              }
            }
            .buttonStyle(BasicButtonStyle(variant: .fill, color: .green))
            .padding(.horizontal, 16)
          }
        }
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
