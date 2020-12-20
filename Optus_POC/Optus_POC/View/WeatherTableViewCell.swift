//
//  WeatherTableViewCell.swift
//  Optus_POC
//
//  Created by Rohit on 12/20/20.
//

import Foundation

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var cityTemperature: UILabel!
    
    func setWeatherCellData(_ cityWeather: Weather) {
        cityName.text = cityWeather.name
        cityTemperature.text = Constant.convertTempFromKelvinToCelcius(kelvinTemprecture: cityWeather.main.temp)
        let weatherImgageIconName = cityWeather.weather.first!.icon
        let weatherImageURL = Constant.weatherImageURL+weatherImgageIconName+"@2x.png"
        //+"@2x.png"
        weatherImageView.loadImageFromURL(weatherImageURL, placeHolder: UIImage.init(named: "weatherPlaceHolder"))

        
    }
}
