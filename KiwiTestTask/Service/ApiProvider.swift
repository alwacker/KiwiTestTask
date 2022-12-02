//
//  ApiProvider.swift
//  KiwiTestTask
//
//  Created by Oleksandr Vaker on 30.11.2022.
//

import Foundation
import Combine
import UIKit

enum ApiMethod: String {
    case get     = "GET"
    case post    = "POST"
}

class ApiProvider {
    private let logQueue = DispatchQueue(label: "com.Kiwi.api-log", qos: .background)

    private lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 120
        configuration.waitsForConnectivity = true
        configuration.httpMaximumConnectionsPerHost = 5
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        configuration.urlCache = .shared
        return URLSession(configuration: configuration)
    }()

    private func log(message: String) {
        logQueue.async {
            print(message)
        }
    }

    func request<T: Decodable>(
        endPoint: String,
        method: ApiMethod = .get,
        params: Parameters? = nil,
        headers: HTTPHeaders? = nil,
        query: Query? = nil,
        httpCodes: HTTPCodes = .success
    ) -> AnyPublisher<T, Error> {
        do {
            let request = try createRequest(endPoint, method: method, parameters: params, headers: headers, query: query)
            return session
                .dataTaskPublisher(for: request)
                .requestJSON(httpCodes: httpCodes)
        } catch let error {
            return Fail<T, Error>(error: error).eraseToAnyPublisher()
        }
    }

    private func createRequest(
        _ url: String,
        method: ApiMethod = .get,
        parameters: Parameters? = nil,
        headers: HTTPHeaders? = nil,
        query: Query? = nil
    ) throws -> URLRequest {
        let debugString = "DEBUG: - ApiProvider: create request to \(url), method \(method), params: \(String(describing: parameters))"
        self.log(message: debugString)
        var components = URLComponents(string: url)
        guard let url = URL(string: url) else {
            throw ApiError.invalidURL
        }
        if let query = query {
            components?.queryItems = query.compactMap { URLQueryItem(name: $0.key, value: $0.value) }
        }
        var request = URLRequest(url: components?.url ?? url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        if let params = parameters {
            request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        }
        return request
    }
}
