//
//  ApiGateway.swift
//  KiwiTestTask
//
//  Created by Oleksandr Vaker on 30.11.2022.
//

import Foundation

protocol Gateway {
    func getEndpointURL(endPoint: ApiEndPoint) -> String
    func getEndpointURL(endPoint: String) -> String
}

class ApiGateway: Gateway {
    private let baseUrl: String

    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }

    func getEndpointURL(endPoint: ApiEndPoint) -> String {
        let url = endPoint.rawValue.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? endPoint.rawValue
        return prepareUrl(endPoint: url)
    }

    func getEndpointURL(endPoint: String) -> String {
        prepareUrl(endPoint: endPoint)
    }

    private func prepareUrl(endPoint: String) -> String {
        let url = endPoint.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? endPoint
        return "\(baseUrl)\(url)"
    }
}
