//
//  PopularFlightsViewModel.swift
//  KiwiTestTask
//
//  Created by Oleksandr Vaker on 30.11.2022.
//

import Foundation
import Combine

class PopularFlightsViewModel: ObservableObject {

    enum State {
        case loading
        case error(Error)
        case success(flights: [Flight])
        case none
    }

    //inputs
    let didAppear = PassthroughSubject<Date, Never>()
    let selectedItem = PassthroughSubject<Flight?, Never>()

    //outputs

    @Published var state: State = .none

    private let service: FlightsModuleService
    private var cancelBag = Set<AnyCancellable>()

    init(service: FlightsModuleService, router: FlightsModuleRouter) {
        self.service = service

        didAppear
            .sink { [weak self] in self?.loadData(with: $0) }
            .store(in: &cancelBag)

        selectedItem
            .unwrap()
            .sink { router.showFlightDetail(flight: $0) }
            .store(in: &cancelBag)
    }

    private func loadData(with date: Date) {
        state = .loading
        service.getPopularFlights(date: date)
            .sink { [weak self] error in
                switch error {
                case let .failure(error):
                    self?.state = .error(error)
                default:
                    break
                }
            } receiveValue: { [weak self] result in
                self?.state = .success(flights: result)
            }
            .store(in: &cancelBag)
    }
}
