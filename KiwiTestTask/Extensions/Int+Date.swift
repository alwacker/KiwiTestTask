//
//  Int+Date.swift
//  KiwiTestTask
//
//  Created by Oleksandr Vaker on 01.12.2022.
//

import Foundation

enum DateFormats: String {
    case fullDate = "dd MMMM"
    case dateOnly = "dd MMM"
    case timeOnly = "HH:mm"
    case dateWithYear = "dd/MM/yyyy"
}

extension Int {
    func convertTimestampToDate() -> Date {
        let date = Date(timeIntervalSince1970: Double(self))
        return date
    }

    func convertTimestampToString(with format: DateFormats) -> String {
        let date = Date(timeIntervalSince1970: Double(self))
        let formatter = DateFormatter()
        formatter.calendar = Calendar.current
        formatter.dateFormat = format.rawValue
        return formatter.string(from: date)
    }
}
