//
//  DIContainer.swift
//  KiwiTestTask
//
//  Created by Oleksandr Vaker on 30.11.2022.
//

import Foundation

final class DIContainer {
    lazy var gateway: ApiGateway = {
        ApiGateway(baseUrl: AppURL.baseURL)
    }()

    lazy var flightsModuleService: FlightsModuleService = {
        FlightsModuleService(api: FlightsApi(base: gateway))
    }()
}
