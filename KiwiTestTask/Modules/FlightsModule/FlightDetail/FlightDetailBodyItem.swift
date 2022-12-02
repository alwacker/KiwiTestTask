//
//  FlightDetailBodyItem.swift
//  KiwiTestTask
//
//  Created by Oleksandr Vaker on 02.12.2022.
//

import Foundation
import SwiftUI

struct FlightDetailBodyItem: View {
    var flightRoute: Route
    var showDate = false
    var showLayover = false
    var yOffset: CGFloat = 0
    var showTopView = false
    var showBottomView = false
    var nextFlightTime: Int? = nil

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20.0)
                .fill(.white)
                .addBackgroundShadow()
            HStack {
                flightTimingView()
                    .padding(.leading, 20.0)
                setUpFlightPath()
                setUpFlightCitiesView()
                    .overlay(
                        setUpOuterLayerTexts()
                            .frame(width: 200.0)
                            .padding(.leading, 30.0)
                    )
                Spacer()
            }
        }
        .padding(.horizontal, 20.0)
        .padding(.top, showDate ? 120.0 : 70.0)
        .padding(.bottom, showLayover ? 70.0 : 120.0)
        .frame(maxWidth: .infinity)
        .frame(height: showDate ? 245.0 : 245.0 - (yOffset / 2.0))
    }

    private func setUpOuterLayerTexts() -> some View {
        VStack(alignment: .leading) {
            if showDate{
                Text(flightRoute.dTime?.convertTimestampToString(with: .fullDate) ?? "")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .offset(x: (showLayover ? 0 : -10.0), y: -27.0)
            }
            Spacer()

            if showLayover {
                Text("\(differenceBetweenDates(aTime: nextFlightTime ?? 0, dTime: flightRoute.aTime ?? 0)) layover")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .offset(x: 0, y: 32.0)
            }
        }
    }

    private func setUpFlightCitiesView() -> some View {
        VStack(alignment:.leading) {
            VStack(alignment: .leading) {
                Text(flightRoute.cityCodeFrom ?? "")
                    .font(.system(size: 20))
                    .font(.title3)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                Text(flightRoute.cityFrom ?? "")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
            }
            .padding(.top, 10.0)
            Spacer()
            CacheImage(url: flightRoute.airlineImageURL)
                .scaledToFit()
                .frame(width: 40.0, height: 40.0, alignment: .center)
            Spacer()
            VStack(alignment: .leading) {
                Text(flightRoute.cityCodeTo ?? "")
                    .font(.system(size: 20.0))
                    .font(.title3)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                Text(flightRoute.cityTo ?? "")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
            }
            .padding(.bottom, 15.0)
        }
    }

    private func setUpFlightPath() -> some View {
        ZStack {
            Rectangle()
                .fill(.pink.opacity(0.5))
                .frame(width: 0.5)
                .padding(.horizontal, 30.0)
                .padding(.top, showTopView ? -15.0 : 30.0)
                .padding(.bottom, showBottomView ? -15.0 : 30.0)
            VStack {
                if showDate {
                    VStack {
                        Image(systemName: "calendar.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.pink.opacity(0.5))
                            .frame(width: 20.0, height: 20.0, alignment: .center)
                            .offset(x:0, y: -30.0)
                    }
                }
                Spacer()
                if showLayover {
                    VStack {
                        Image(systemName: "clock.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.pink.opacity(0.5))
                            .frame(width: 20.0, height: 20.0, alignment: .center)
                            .offset(x: 0, y: 35.0)
                    }
                }
            }

            VStack {
                setUpFlightPathCircle()
                    .padding(.top, 20.0)
                Spacer()
                Image(systemName: "airplane")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.pink.opacity(0.5))
                    .rotationEffect(Angle(degrees: 90.0))
                    .frame(width: 25.0, height: 25.0, alignment: .center)
                Spacer()
                setUpFlightPathCircle()
                    .padding(.bottom, 20.0)
            }
        }
        .frame(width:45)
    }

    private func setUpFlightPathCircle() -> some View {
        Circle()
            .fill(.white)
            .frame(width: 10.0, height: 10.0)
            .background(
                Circle()
                    .fill(.pink.opacity(0.5))
                    .frame(width: 18.0, height: 18.0)
            )
    }

    private func flightTimingView() -> some View {
        VStack(alignment: .center) {
            Text(flightRoute.dTime?.convertTimestampToString(with: .timeOnly) ?? "")
                .foregroundColor(.black)
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding(.top,15)
            Spacer()
            Image(systemName: "clock")
                .resizable()
                .scaledToFit()
                .foregroundColor(.black)
                .frame(width: 15.0, height: 15.0, alignment: .center)
            Text(differenceBetweenDates(aTime: flightRoute.aTime ?? 0, dTime: flightRoute.dTime ?? 0))
                .foregroundColor(.black)
                .font(.caption2)
                .fontWeight(.thin)
            Spacer()
            Text(flightRoute.aTime?.convertTimestampToString(with: .timeOnly) ?? "")
                .foregroundColor(.black)
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding(.bottom, 15.0)
        }
        .frame(width: 60.0)
    }

    private func differenceBetweenDates(aTime: Int, dTime: Int) -> String {
        let dTimeinterval = TimeInterval(dTime)
        let dDate = Date(timeIntervalSince1970: dTimeinterval)
        let aTimeinterval = TimeInterval(aTime)
        let aDate = Date(timeIntervalSince1970: aTimeinterval)
        let diffComponents = Calendar.current.dateComponents([.hour, .minute], from: dDate, to: aDate)
        let hours = diffComponents.hour
        let minutes = diffComponents.minute
        return ("\(hours ?? 0)h \(minutes ?? 0)m")
    }
}
