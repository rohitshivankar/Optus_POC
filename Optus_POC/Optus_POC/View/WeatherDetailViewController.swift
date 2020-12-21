//
//  WeatherDetailViewController.swift
//  Optus_POC
//
//  Created by Rohit on 12/21/20.
//

import Foundation
import UIKit


class WeatherDetailViewController: UIViewController {
    
    let weatherDetailViewModel = WeatherDetailViewModel()
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var shortDescriptionLabel: UILabel!
    @IBOutlet var iconImage: UIImageView!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var longDescriptionLabel: UILabel!
    @IBOutlet weak var weatherCollectionView: UICollectionView!
    
    var cityWeather: Weather? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        weatherDetailViewModel.setWetherItemData(cityWeather: cityWeather!)
        
        if(cityWeather!.isDay){
            self.view.backgroundColor = UIColor(patternImage: UIImage(named:"Sun")!)
        } else {
            self.view.backgroundColor = UIColor(patternImage: UIImage(named:"Night")!)
        }
        
        // hide the navigation bar
        //self.navigationController?.setNavigationBarHidden(true, animated: false)
        weatherCollectionView.reloadData()
    }
    
    func configureData() {
        cityNameLabel.text = cityWeather?.name
        shortDescriptionLabel.text = cityWeather?.weather[0].main
        let weatherImgageIconName = cityWeather?.weather.first!.icon
        let weatherImageURL = Constant.weatherImageURL+weatherImgageIconName!+"@2x.png"
    
        iconImage.loadImageFromURL(weatherImageURL, placeHolder: UIImage.init(named: "weatherPlaceHolder"))
        
        temperatureLabel.text = Constant.convertTempFromKelvinToCelcius(kelvinTemprecture: (cityWeather?.main.temp)!)//cityWeather?.main.temp.formatTempString()
        
        longDescriptionLabel.text = "TODAY: \((cityWeather?.weather[0].description)!) with high of \(Constant.convertTempFromKelvinToCelcius(kelvinTemprecture: (cityWeather?.main.temp_max)!)) and low of \(Constant.convertTempFromKelvinToCelcius(kelvinTemprecture: (cityWeather?.main.temp_min)!))."
    }
    
}

//MARK: - collection view  data source methods
extension WeatherDetailViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    
func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return weatherDetailViewModel.completeWeatherItemList.count
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 150, height: 150)
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherDetailCollectionViewCell", for: indexPath) as! WeatherDetailCollectionViewCell
    cell.weatherDescriptionLabel.text = weatherDetailViewModel.completeWeatherItemList[indexPath.row].itemName
    cell.weatherDescriptionValue.text = weatherDetailViewModel.completeWeatherItemList[indexPath.row].itemValue
    return cell
}
}

