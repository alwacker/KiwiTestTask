//
//  BaseApi.swift
//  KiwiTestTask
//
//  Created by Oleksandr Vaker on 30.11.2022.
//

import Foundation
import Combine
import UIKit

typealias HTTPHeaders = [String: String]
typealias Parameters = [String: Any]
typealias Query = [String: String]
typealias HTTPCode = Int
typealias HTTPCodes = Range<HTTPCode>

extension HTTPCodes {
    static let success = 200 ..< 300
}

class BaseApi {
    private let base: ApiGateway

    init(base: ApiGateway) {
        self.base = base
    }

    init(baseUrl: String) {
        self.base = ApiGateway(baseUrl: baseUrl)
    }

    func request<T: Decodable>(
        endPoint: String,
        method: ApiMethod = .get,
        params: [String: Any]? = nil,
        headers: HTTPHeaders? = nil,
        query: Query? = nil
    ) -> AnyPublisher<T, Error> {
        ApiProvider().request(endPoint: base.getEndpointURL(endPoint: endPoint), method: method, params: params, headers: headers, query: query)
    }

    func request<T: Decodable>(
        endPoint: ApiEndPoint,
        method: ApiMethod = .get,
        params: [String: Any]? = nil,
        headers: HTTPHeaders? = nil,
        query: Query? = nil
    ) -> AnyPublisher<T, Error> {
        ApiProvider().request(endPoint: base.getEndpointURL(endPoint: endPoint), method: method, params: params, headers: headers, query: query)
    }
}
