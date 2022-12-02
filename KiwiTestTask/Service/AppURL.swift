//
//  AppURL.swift
//  KiwiTestTask
//
//  Created by Oleksandr Vaker on 01.12.2022.
//

import Foundation

struct AppURL {
    private static let imageBaseUrl = "https://images.kiwi.com"

    static let baseURL = "https://api.skypicker.com"

    static var destinationPhoto: String {
        return imageBaseUrl + "/photos/600x330/"
    }

    static var airlinePhoto: String {
        return imageBaseUrl + "/airlines/64/"
    }
}
