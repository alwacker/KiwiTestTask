//
//  Gradient.swift
//  KiwiTestTask
//
//  Created by Oleksandr Vaker on 01.12.2022.
//

import Foundation
import SwiftUI

struct BottomGradientLayer: ViewModifier {
    func body(content: Content) -> some View {
        content
            .overlay(
                VStack {
                    Spacer()
                    Rectangle()
                        .foregroundColor(.clear)
                        .background(LinearGradient(gradient: Gradient(colors: [.clear, .black.opacity(0.8)]), startPoint: .top, endPoint: .bottom))
                }
            )
    }
}

struct BackgroundShadow: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .gray.opacity(0.2), radius: 8, x: -8, y: -8)
            .shadow(color: .black.opacity(0.3), radius: 8, x: 8, y: 8)
    }
}

extension View {
    func addGradientLayerToBottom() -> some View {
        modifier(BottomGradientLayer())
    }

    func addBackgroundShadow() -> some View {
        modifier(BackgroundShadow())
    }
}

