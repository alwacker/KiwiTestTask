//
//  FlightDetailView.swift
//  KiwiTestTask
//
//  Created by Oleksandr Vaker on 01.12.2022.
//

import Foundation
import SwiftUI

struct FlightDetailView: View {

    var flight: Flight

    var body: some View {
        ZStack {
            Color.pink
                .ignoresSafeArea()
                .opacity(0.3)
            ScrollView(showsIndicators: false) {
                VStack{
                    CacheImage(url: flight.destinationImageURL)
                        .cornerRadius(10.0)
                        .aspectRatio(4/3, contentMode: .fill)
                        .addGradientLayerToBottom()
                    FlightDetailHeader(flight: flight)
                        .offset(x: 0, y: -80.0)
                    setUpDetailBody()
                }
            }
        }
    }

    private func setUpDetailBody() -> some View {
        VStack {
            bannerView()
                .frame(height: 50.0)
                .background(.clear)
                .padding(.horizontal)
                .padding(.top, -20.0)

            if let routes = flight.route {
                if routes.count > 0 {
                    VStack {
                        ForEach(Array(zip(routes.indices, routes)), id: \.0) { index, item in
                            switch (index) {
                            case 0:
                                FlightDetailBodyItem(
                                    flightRoute: routes[index],
                                    showDate: true,
                                    showLayover: routes.count == 1 ? false : true,
                                    showTopView: true,
                                    showBottomView: routes.count == 1 ? false : true,
                                    nextFlightTime: routes.count == 1 ? nil : routes[index + 1].dTime
                                )
                            case (routes.count - 1):
                                FlightDetailBodyItem(
                                    flightRoute: routes[index],
                                    showTopView: true
                                )
                            default:
                                FlightDetailBodyItem(
                                    flightRoute: routes[index],
                                    showLayover: true,
                                    yOffset: 90,
                                    showTopView: true,
                                    showBottomView: true,
                                    nextFlightTime: routes[index + 1].dTime
                                )
                            }
                        }
                    }
                    .padding(.bottom, 50.0)
                }
            }
            Spacer()
        }
        .padding(.top, -50.0)
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
