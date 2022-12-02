//
//  FlightsEntity.swift
//  KiwiTestTask
//
//  Created by Oleksandr Vaker on 02.12.2022.
//

import Foundation

struct PopularFlightsEntity: Codable, Identifiable {
    let id = UUID().uuidString
    let searchID: String?
    let currency: String?
    let data: [Flight]?

    enum CodingKeys: String, CodingKey {
        case searchID = "search_id"
        case currency
        case data
    }
}

struct Flight: Codable, Identifiable, Hashable {
    var identifier: String {
        return UUID().uuidString
    }

    public func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }

    static func == (lhs: Flight, rhs: Flight) -> Bool {
        return lhs.cityTo == rhs.cityTo && lhs.countryTo == rhs.countryTo
    }

    let id, flyFrom, flyTo, cityFrom: String?
    let cityCodeFrom, cityTo, cityCodeTo: String?
    let countryFrom, countryTo: Country?
    let dTime, dTimeUTC, aTime, aTimeUTC: Int?
    let flyDuration: String?
    let price: Int?
    let route: [Route]?
    let bookingToken: String?
    let deepLink: String?
    let mapIdfrom, mapIdto: String?
    var destinationImageURL: URL {
        URL(string: AppURL.destinationPhoto + "\(mapIdto ?? "photos").jpg")!
    }
    var finalPrice: String {
        "\(price ?? 0)" + " €"
    }

    var departureTime: Date {
        dTime?.convertTimestampToDate() ?? Date()
    }

    enum CodingKeys: String, CodingKey {
        case id, flyFrom, flyTo, cityFrom, cityCodeFrom, cityTo, cityCodeTo, countryFrom, countryTo, dTime, dTimeUTC, aTime, aTimeUTC
        case flyDuration = "fly_duration"
        case price
        case route
        case bookingToken = "booking_token"
        case deepLink = "deep_link"
        case mapIdfrom, mapIdto
    }
}

struct Route: Codable, Identifiable {
    let id, flyFrom, flyTo: String?
    let cityFrom, cityCodeFrom, cityTo, cityCodeTo: String?
    let dTime, dTimeUTC, aTime, aTimeUTC: Int?
    let airline: String?
    let flightNo: Int?
    let price: Int?
    var airlineImageURL: URL {
        URL(string: AppURL.airlinePhoto + "\(airline ?? "").png")!
    }

    enum CodingKeys: String, CodingKey {
        case id
        case flyFrom, flyTo, cityFrom, cityCodeFrom, cityTo, cityCodeTo, dTime, dTimeUTC, aTime, aTimeUTC, airline
        case flightNo = "flight_no"
        case price
    }
}

struct Country: Codable, Equatable {
    let code, name: String?
}
