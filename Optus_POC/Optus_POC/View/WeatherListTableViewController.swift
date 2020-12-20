//
//  ViewController.swift
//  Optus_POC
//
//  Created by Rohit on 12/20/20.
//

import UIKit

class WeatherListTableViewController: UITableViewController {

    var weatherDataModel = WeatherDataViewModel()
    var buttonFahrenheit =  UIButton()
    var buttonCelsius =  UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        getWeatherDataFromViewModel()
        self.tableView.accessibilityIdentifier = "Table-WeatherListTableView"
    }
    
    //MARK: - Class Private Functions
    
    /// Fetch weather data from view model class
    ///
    /// Use this method to get data from ViewModel class and manage its response status
    func getWeatherDataFromViewModel() {
        print("method getWeatherDataFromViewModel called")
        weatherDataModel.getWeatherForCitiesList {result in
            switch(result) {
            case .success:
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: - Table view delegate and data source methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherDataModel.weatherListCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell") as! WeatherTableViewCell
        //cell.cityName.text = "Pune"
        //cell.cityTemperature.text = "32"
        let cityWeather = weatherDataModel.weatherListArray[indexPath.row]
        cell.setWeatherCellData(cityWeather)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfSectionsInTableView section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // handle delete, remove city name from weatehr list
        }
    }
}

