//
//  FlightDetailHeaderView.swift
//  KiwiTestTask
//
//  Created by Oleksandr Vaker on 02.12.2022.
//

import Foundation
import SwiftUI

struct FlightDetailHeader: View {

    @State private var showingSubview = false

    var flight: Flight

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(flight.cityCodeFrom ?? "")
                    .font(.system(size: 28.0))
                    .font(.title3)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                Text(flight.cityFrom ?? "")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
            Spacer()
            setUpFlightPathView()
            Spacer()
            VStack(alignment: .leading) {
                Text(flight.cityCodeTo ?? "")
                    .font(.system(size: 28))
                    .font(.title3)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                Text(flight.cityTo ?? "")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
        }
        .padding(.horizontal, 20.0)
        .padding(.bottom, 8.0)
        .frame(maxWidth: .infinity)
        .onAppear {
            showingSubview.toggle()
        }
    }

    private func setUpFlightPathView() -> some View {
        VStack {
            ZStack {
                HStack(spacing: .zero) {
                    Circle()
                        .stroke(lineWidth: 2.0)
                        .fill(.pink.opacity(0.5))
                        .frame(width: 6.0, height: 6.0)
                    Rectangle()
                        .fill(.pink.opacity(0.5))
                        .frame(height: 1.0)
                        .overlay(setUpAirplaneCircle())
                    Circle()
                        .stroke(lineWidth: 2.0)
                        .fill(.pink.opacity(0.5))
                        .frame(width: 6.0, height: 6.0)
                }
            }
        }
        .offset(x: .zero, y: 4.0)
    }

    private func setUpAirplaneCircle() -> some View {
        GeometryReader { geometry in
            Image(systemName: "airplane.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 34.0)
                .frame(height: 34.0)
                .foregroundColor(.pink.opacity(0.5))
                .padding(.horizontal, 8.0)
                .background(Circle().fill(.white))
                .offset(x: showingSubview ? geometry.size.width - 45.0 : 0, y: -15.0)
                .animation(Animation.linear(duration: 20.0).repeatForever(autoreverses: false), value: UUID())
        }
    }
}
