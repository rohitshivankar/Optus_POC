//
//  Extension.swift
//  Optus_POC
//
//  Created by Rohit on 12/21/20.
//

import Foundation
import UIKit

extension Int {
    func formatDate(timezoneOffset: Int) -> String {
        let time = Date(timeIntervalSince1970: Double(self))
        let timezone = TimeZone(secondsFromGMT: timezoneOffset)

        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        formatter.timeZone = timezone
        
        return formatter.string(from: time)
    }
    
    func formatHumidity() -> String {
        return String(format: "%d%%", self)
    }

    func formatPressure() -> String {
        return String(format: "%d hPa", self)
    }
    
    func formatVisibility() -> String {
        let visibility = Double(self)/1000
        return String(format: "%.1f km%@", visibility, visibility > 1 ? "s" : "")
    }
}

extension Double {
    func formatWind() -> String {
        return String(format: "%.1f kph", self)
    }
}
