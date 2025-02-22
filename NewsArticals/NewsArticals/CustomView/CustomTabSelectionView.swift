//
//  CustomTabSelectionView.swift
//  NewsArticals
//
//  Created by Sachin Daingade on 04/10/24.
//

import SwiftUI

enum SDButtonState {
    case normal
    case selected
    
    func getButtonStateColor() -> Color {
        switch self {
        case .normal:
            return Color(.orange)
        case .selected:
            return Color(.green)
        }
    }
    
    func getButtonTappedColor() -> Color {
        switch self {
        case .normal:
            return Color(.orange)
        case .selected:
            return Color(.green)
        }
    }
}

struct CustomTabButtonView: View {
    @State private var isPressed: Bool = false
    let text: String
    let iconName: String
    var buttonState: SDButtonState = .normal
    var action: () -> Void
    
    var body: some View {
        ZStack {
            Button {
                
            } label: {
                SDTabbarButtonImage(systemImageName: iconName, state: buttonState, isPressed: true)
                Text(text)
                    .foregroundColor(buttonState.getButtonStateColor())
                
            } .pressEvents {
                withAnimation(.easeOut(duration: 0.1)) {
                    isPressed = true
                }
            } onRelease: {
                withAnimation(.easeOut(duration: 0.1)) {
                    isPressed = true
                    action()
                }
            }
        }
    }
}

struct SDTabbarButtonImage: View {
    let systemImageName: String
    var state: SDButtonState = .normal
    var isPressed: Bool = false
    init(systemImageName: String, state:  SDButtonState, isPressed: Bool = true) {
        self.systemImageName = systemImageName
        self.state = state
        self.isPressed = isPressed
    }
    var body: some View {
        Image(systemName:systemImageName)
            .resizable()
            .renderingMode(.template)
            .foregroundColor(isPressed ? state.getButtonTappedColor() : state.getButtonTappedColor())
            .frame (width: 60,height: 20)
    }
}

struct ButtonPress: ViewModifier {
    var onPress: () -> Void
    var onRelease: () -> Void
    func body (content: Content) -> some View {
        content
            .simultaneousGesture (
                DragGesture (minimumDistance: 0)
                    .onChanged ({_ in
                        onPress()
                    })
                    .onEnded ( { _ in
                        onRelease()
                    })
            )
    }
}

extension View {
    func pressEvents(onPress: @escaping (() -> Void), onRelease: @escaping (() -> Void)) -> some View {
        modifier(ButtonPress(onPress: {
            onPress()
        }, onRelease: {
            onRelease()
        }))
    }
}

