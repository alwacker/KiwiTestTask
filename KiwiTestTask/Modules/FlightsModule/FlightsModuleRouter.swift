//
//  FlightsModuleRouter.swift
//  KiwiTestTask
//
//  Created by Oleksandr Vaker on 01.12.2022.
//

import Foundation
import Combine
import SwiftUI

class FlightsModuleRouter {
    private let container: DIContainer
    private let transitionHandler: TransitionHandler
    private var cancelBag = Set<AnyCancellable>()

    init(container: DIContainer, transitionHandler: TransitionHandler) {
        self.container = container
        self.transitionHandler = transitionHandler
    }

    func showFlightDetail(flight: Flight) {
        let view = FlightDetailView(flight: flight)
        let viewController = UIHostingController(rootView: view)
        transitionHandler.modal(controller: viewController, animated: true)
    }
}
