//
//  ViewController.swift
//  Optus_POC
//
//  Created by Rohit on 12/20/20.
//

import Foundation

struct WeatherReponse: Codable {
    let cnt: Int
    let list: [Weather]
}

struct Weather: Codable, Identifiable {
    let id, dt: Int
    let name: String
    let coord: Coord
    let sys: Sys
    let weather: [WeatherData]
    let main: Main
    let wind: Wind
    let clouds: Cloud
    let visibility: Int?
    
    var isDay: Bool {
        return dt > sys.sunrise && dt < sys.sunset ? true : false
    }
}

struct Coord: Codable {
    let lat, lon: Double
}

struct Sys: Codable {
    let timezone, sunrise, sunset: Int
    
    var localSunriseTime: String {
        return sunrise.formatDate(timezoneOffset: timezone)
    }
    
    var localSunsetTime: String {
        return sunset.formatDate(timezoneOffset: timezone)
    }
}

struct WeatherData: Codable, Identifiable {
    let id: Int
    let main, description, icon: String
}

struct Main: Codable {
    let temp, feels_like, temp_min, temp_max: Double
    let pressure, humidity: Int
}

struct Wind: Codable {
    let speed: Double
    let deg: Double
}

struct Cloud: Codable {
    let all: Int
}
