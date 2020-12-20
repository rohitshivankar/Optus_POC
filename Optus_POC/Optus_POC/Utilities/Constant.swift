//
//  Constant.swift
//  Optus_POC
//
//  Created by Rohit on 12/20/20.
//

import Foundation

class Constant {

    static let baseURL = "https://api.openweathermap.org/data/"
    static let urlVersion = "2.5/"
    static let getWeatherListForGroupURL = baseURL+urlVersion+"group?APPID=" + valueForAPIKey(keyName:"API_CLIENT_KEY") + "&id="
    static let weatherImageURL = "https://openweathermap.org/img/wn/"
    
    /// Method to convert kelvin temp to desired unit format
    ///
    /// - Parameter kelvinTemprecture: Kelvin temp received from service and will be used to convert is desired format
    static func convertTempFromKelvinToCelcius(kelvinTemprecture: Double) -> String {
        var measurement = Measurement(value: kelvinTemprecture, unit: UnitTemperature.kelvin)
        
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.unitStyle = .short
        measurementFormatter.numberFormatter.maximumFractionDigits = 0
        measurementFormatter.unitOptions = .providedUnit
        if(UserDefaultHelper.getTempratureUnit() == "C"){
            measurement.convert(to: UnitTemperature.celsius)
        } else {
            measurement.convert(to: UnitTemperature.fahrenheit)
            return measurementFormatter.string(from: measurement) + "F"
        }
        return measurementFormatter.string(from: measurement)
    }
    
    /// Method to read open weather api key store in plist file
    ///
    /// - Parameter keyName: Key name which will be used to read data from plist file
    static func valueForAPIKey(keyName:String) -> String {
        let filePath = Bundle.main.path(forResource: "ApiKeys", ofType: "plist")
        let plist = NSDictionary(contentsOfFile:filePath!)
        let value = plist?.object(forKey: keyName) as! String
        return value
    }
}
