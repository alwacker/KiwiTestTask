//
//  SpinnerView.swift
//  KiwiTestTask
//
//  Created by Oleksandr Vaker on 02.12.2022.
//

import Foundation
import SwiftUI

struct SpinnerCircle: View {
    let start: CGFloat
    let end: CGFloat
    let rotation: Angle
    let colors: [Color]

    var body: some View {
        Circle()
            .trim(from: start, to: end)
            .stroke(style: StrokeStyle(lineWidth: 3.0, lineCap: .round))
            .fill(LinearGradient(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .topTrailing))
            .rotationEffect(rotation)
    }
}

struct SpinnerView: View {

    let rotationTime: Double = 0.75
    let fullRotation: Angle = .degrees(360)
    static let initialDegree: Angle = .degrees(270)
    let animationTime = 0.6

    @State var timer: Timer?
    @State var spinnerStart: CGFloat = 0.0
    @State var spinnerEndS1: CGFloat = 0.6
    @State var rotationDegreeS1 = initialDegree

    var body: some SwiftUI.View {
        ZStack {
            SpinnerCircle(
                start: spinnerStart,
                end: spinnerEndS1,
                rotation: rotationDegreeS1,
                colors: [.pink, .pink.opacity(0.8), .pink.opacity(0.5), .pink.opacity(0.1)])

            SpinnerCircle(
                start: spinnerStart,
                end: 1.0,
                rotation: rotationDegreeS1,
                colors: [.pink.opacity(0.1)])
        }
        .frame(width: 60, height: 60)
        .onAppear {
            timer = Timer.scheduledTimer(withTimeInterval: animationTime, repeats: true) { _ in
                self.animateSpinner(with: (rotationTime * 2) - 0.025) {
                    self.rotationDegreeS1 += fullRotation
                }
            }
        }
        .onDisappear {
            timer?.invalidate()
        }

    }

    private func animateSpinner(with timeInterval: Double, completion: @escaping (() -> Void)) {
        withAnimation(Animation.easeInOut(duration: rotationTime)) {
            completion()
        }
    }
}
