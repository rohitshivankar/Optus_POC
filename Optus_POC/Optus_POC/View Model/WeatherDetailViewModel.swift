//
//  WeatherDetailViewModel.swift
//  Optus_POC
//
//  Created by Rohit on 12/21/20.
//

import Foundation
class WeatherDetailViewModel {
    
    var completeWeatherItemList: [WeatherItem] = [WeatherItem]()
    
    func setWetherItemData(cityWeather: Weather) {
        completeWeatherItemList .append(WeatherItem(itemName: "Sunrise", itemValue: cityWeather.sys.localSunriseTime))
        completeWeatherItemList .append(WeatherItem(itemName: "Sunset", itemValue: cityWeather.sys.localSunsetTime))
        completeWeatherItemList .append(WeatherItem(itemName: "Feels Like", itemValue: Constant.convertTempFromKelvinToCelcius(kelvinTemprecture: (cityWeather.main.feels_like))))
        completeWeatherItemList .append(WeatherItem(itemName: "Humidity", itemValue: cityWeather.main.humidity.formatHumidity()))
        completeWeatherItemList .append(WeatherItem(itemName: "Presure", itemValue: cityWeather.main.pressure.formatPressure()))
        completeWeatherItemList .append(WeatherItem(itemName: "Wind", itemValue: self.getDirection(degrees: cityWeather.wind.deg , speed: cityWeather.wind.speed )))
        completeWeatherItemList .append(WeatherItem(itemName: "Visibility", itemValue: cityWeather.visibility!.formatVisibility()))
    }
    
    // get the proper direction of wind based on the degrees
    func getDirection(degrees: Double, speed: Double) -> String {
        var direction = ""
        if (degrees != -1) {
            if(degrees > 23 && degrees <= 67){
                direction = "NE";
            } else if(degrees > 68 && degrees <= 112) {
                direction = "E";
            } else if(degrees > 113 && degrees <= 167) {
                direction = "SE";
            } else if(degrees > 168 && degrees <= 202) {
                direction = "S";
            } else if(degrees > 203 && degrees <= 247) {
                direction = "SW";
            } else if(degrees > 248 && degrees <= 293) {
                direction = "W";
            } else if(degrees > 294 && degrees <= 337) {
                direction = "NW";
            } else if(degrees >= 338 || degrees <= 22) {
                direction = "N";
            }
            return "\(direction) \(speed.formatWind())"
        }
        
        return speed.formatWind()
    }
}
