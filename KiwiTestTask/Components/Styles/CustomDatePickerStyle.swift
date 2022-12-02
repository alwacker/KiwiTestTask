//
//  CustomDatePickerStyle.swift
//  KiwiTestTask
//
//  Created by Oleksandr Vaker on 01.12.2022.
//

import Foundation
import SwiftUI

struct CustomDatePickerStyle: DatePickerStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            HStack {
                Button {
                    configuration.selection = Calendar.current.date(byAdding: .day, value: -1, to: configuration.selection)!
                } label: {
                    Image(systemName: "arrow.left")
                        .padding()
                        .tint(.pink)
                        .background(.thinMaterial)
                        .clipShape(Circle())
                }
                .shadow(color: .gray.opacity(0.3), radius: 8, x: -8, y: -8)
                .shadow(color: .black.opacity(0.2), radius: 8, x: 8, y: 8)
                .disabled(configuration.selection.convertToString() == Date().convertToString())

                Spacer()

                Text(setUpTitle(configuration: configuration))
                    .font(.system(size: 15.0, weight: .bold))

                Spacer()

                Button {
                    configuration.selection = Calendar.current.date(byAdding: .day, value: 1, to: configuration.selection)!
                } label: {
                    Image(systemName: "arrow.right")
                        .padding()
                        .tint(.pink)
                        .background(.thinMaterial)
                        .clipShape(Circle())
                }
                .shadow(color: .gray.opacity(0.3), radius: 8, x: -8, y: -8)
                .shadow(color: .black.opacity(0.2), radius: 8, x: 8, y: 8)
            }
        }
    }

    private func setUpTitle(configuration: Configuration) -> String {
        if configuration.selection.convertToString() == Date().convertToString() {
            return "Today, \(configuration.selection.formatted(date: .long, time: .omitted))"
        } else {
            return configuration.selection.formatted(date: .long, time: .omitted)
        }
    }
}
