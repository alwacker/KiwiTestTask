//
//  FlightsModuleService.swift
//  KiwiTestTask
//
//  Created by Oleksandr Vaker on 01.12.2022.
//

import Foundation
import Combine

class FlightsModuleService {

    private let api: FlightsApi
    private var dataDictionary: [String: [Flight]] = [:]

    init(api: FlightsApi) {
        self.api = api
    }

    func getPopularFlights(date: Date) -> AnyPublisher<[Flight], Error> {
        api.getPopularFlights(date: date)
            .map { [weak self] in self?.getUniqueDestinations(flights: $0.data, date: date) }
            .unwrap()
            .eraseToAnyPublisher()
    }

    private func getUniqueDestinations(flights: [Flight]?, date: Date) -> [Flight] {
        if dataDictionary.isEmpty {
            guard let flights = flights else { return [] }
            let flightsWithoutDuplicates = removeDuplicateFlights(flights: flights).prefix(5).shuffled()
            dataDictionary[date.convertToString()] = flightsWithoutDuplicates
            return dataDictionary[date.convertToString()] ?? []
        } else {
            guard var flights = flights else { return [] }
            guard let array = dataDictionary[date.convertToString()] else {
                dataDictionary.suffix(2).forEach { (key, value) in
                    guard key != date.convertToString() else { return }
                    value.forEach { flight in
                        flights.removeAll { $0.cityTo == flight.cityTo }
                    }
                }
                let flightsWithoutDuplicates = removeDuplicateFlights(flights: flights).prefix(5).shuffled()
                dataDictionary[date.convertToString()] = flightsWithoutDuplicates
                return dataDictionary[date.convertToString()] ?? []
            }
            return array
        }
    }

    private func removeDuplicateFlights(flights: [Flight]) -> [Flight] {
        var flightsWithoutDuplicates: [Flight] = []
        flights.forEach { flight in
            if flightsWithoutDuplicates.contains(where: { $0.cityTo == flight.cityTo }) {
                return
            } else {
                flightsWithoutDuplicates.append(flight)
            }
        }
        return flightsWithoutDuplicates
    }
}

class FlightsApi: BaseApi {
    func getPopularFlights(date: Date) -> AnyPublisher<PopularFlightsEntity, Error> {
        let query: Query = [
            "v": "3",
            "sort": "popularity",
            "asc": "0",
            "locale": Locale.current.identifier,
            "fly_from": "prague_cz",
            "to": "anywhere",
            "dateFrom": date.convertToString(),
            "typeFlight": "oneway",
            "one_per_date": "1",
            "oneforcity": "1",
            "partner": "skypicker",
            "limit": "5"
        ]
        return request(endPoint: .flights, method: .get, query: query)
    }
}
