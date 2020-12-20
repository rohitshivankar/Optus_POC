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
    
    /// Method to set data on weather list table view cell
    func setWeatherCellWithData() {
        cityName.text = "Pune"
        cityTemperature.text = "32"
    }
}
