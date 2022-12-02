//
//  FlightView.swift
//  KiwiTestTask
//
//  Created by Oleksandr Vaker on 01.12.2022.
//

import Foundation
import SwiftUI

struct FlightView: View {

    var flight: Flight

    @Binding var selectedItem: Flight?

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20.0)
                .fill(Color.white.opacity(0.6))
                .addBackgroundShadow()

            VStack {
                CacheImage(url: flight.destinationImageURL)
                    .id(Date.timeIntervalSinceReferenceDate)
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .padding(.all, 8)
                    .background(.pink.opacity(0.5))
                    .clipShape(Circle())
                    .addBackgroundShadow()
                    .padding(.top, 20.0)

                VStack {
                    VStack {
                        Text(flight.cityTo ?? "")
                            .font(.system(size: 30.0, weight: .bold))
                        Text(flight.countryTo?.name ?? "")
                            .font(.system(size: 20.0, weight: .semibold))

                    }
                    Spacer()
                    Rectangle()
                        .fill(Color.pink.opacity(0.4))
                        .frame(height: 70.0)
                        .overlay(bannerView())
                        .cornerRadius(20.0)
                }
            }
        }
        .padding(.top, 10.0)
        .padding(.bottom, 20.0)
        .onTapGesture {
            selectedItem = flight
        }
    }

    private func bannerView() -> some View {
        HStack(spacing: 25.0) {
            VStack(alignment: .center) {
                Text("Departure")
                    .font(.system(size: 14.0, weight: .semibold))
                Text(flight.departureTime.convertToString())
                    .font(.system(size: 15.0, weight: .regular))
            }
            Divider()
            VStack(alignment: .center) {
                Text("Price")
                    .font(.system(size: 14.0, weight: .semibold))
                Text(flight.finalPrice)
                    .font(.system(size: 15.0, weight: .regular))
            }
            Divider()
            VStack(alignment: .center) {
                Text("Duration")
                    .font(.system(size: 14.0, weight: .semibold))
                Text(flight.flyDuration ?? "")
                    .font(.system(size: 15.0, weight: .regular))
            }
        }
    }
}
