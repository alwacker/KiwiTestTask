//
//  AppRouter.swift
//  KiwiTestTask
//
//  Created by Oleksandr Vaker on 30.11.2022.
//

import Foundation
import UIKit
import SwiftUI
import Combine

class AppRouter {
    private let container: DIContainer

    private var cancelBag = Set<AnyCancellable>()
    
    init(container: DIContainer) {
        self.container = container
    }

    func showPopularFlights() -> UIViewController {
        let router = FlightsModuleRouter(container: container, transitionHandler: self)
        let viewModel = PopularFlightsViewModel(service: container.flightsModuleService, router: router)
        let view = PopularFlightsView(viewModel: viewModel)
        let navigationController = NavigationViewController(rootViewController: UIHostingController(rootView: view))
        return navigationController
    }
}
