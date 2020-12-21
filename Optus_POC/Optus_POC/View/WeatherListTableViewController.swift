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
        self.title = NSLocalizedString("Weather App", comment: "")
        self.view.backgroundColor = UIColor(red: 0/255, green: 197/255, blue: 246/255, alpha: 1) 
        getWeatherDataFromViewModel()
        self.tableView.accessibilityIdentifier = "Table-WeatherListTableView"
        addFooterView()
    }
    
    //MARK: - Class Private Functions
    
    /// Fetch weather data from view model class
    ///
    /// Use this method to get data from ViewModel class and manage its response status
    func getWeatherDataFromViewModel() {
        self.addActivityIndicator()
        print("method getWeatherDataFromViewModel called")
        weatherDataModel.getWeatherForCitiesList {result in
            self.stopActivityIndicator()
            switch(result) {
            case .success:
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                self.displayErrorMessageWith(messageString: error.localizedDescription)
                print(error.localizedDescription)
            }
        }
    }
    
    /// Set footer view on table view
    ///
    /// Use this method to set Celsius and Far button on table view footer
    private func addFooterView() {
        let footerView = UIView()
        footerView.backgroundColor = UIColor.clear
        footerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height:40)
        buttonCelsius.frame = CGRect(x: 20, y: 5, width: 30, height: 30)
        buttonCelsius.setTitle("C", for: .normal)
        buttonCelsius.addTarget(self, action: #selector(self.setCelsiusButtonTapped), for: .touchUpInside)
        buttonCelsius.setTitleColor(UIColor.black, for: .selected)
        buttonCelsius.backgroundColor = UIColor.clear
        let sepratorLabel = UILabel()
        sepratorLabel.frame = CGRect(x: 50, y: 0, width: 5, height: 40)
        sepratorLabel.text = "/"
        sepratorLabel.textColor = UIColor.white
        footerView.addSubview(sepratorLabel)
        buttonFahrenheit.frame = CGRect(x: 55, y: 5, width: 30, height: 30)
        buttonFahrenheit.setTitle("F", for: .normal)
        buttonFahrenheit.setTitleColor(UIColor.black, for: .selected)
        buttonFahrenheit.addTarget(self, action: #selector(self.setFahrenheitButtonTapped), for: .touchUpInside)
        buttonFahrenheit.backgroundColor = UIColor.clear
        if(UserDefaultHelper.getTempratureUnit() == "C") {
            buttonCelsius.isSelected = true
        } else {
            buttonFahrenheit.isSelected = true
        }
        footerView.addSubview(buttonCelsius)
        footerView.addSubview(buttonFahrenheit)
        self.tableView.tableFooterView = footerView
    }
    
    /// setCelsiusButtonTapped methos will be called as user tap on C button on screen
    ///
    /// Use this method to set temp unit in user default
    @objc private func setCelsiusButtonTapped()
    {
        buttonCelsius.isSelected = true
        buttonFahrenheit.isSelected = false
        UserDefaultHelper.setTempratureUnit(unit: "C")
        self.tableView.reloadData()
    }
    
    /// setFahrenheitButtonTapped methos will be called as user tap on F button on screen
    ///
    /// Use this method to set temp unit in user default
    @objc private func setFahrenheitButtonTapped()
    {
        buttonCelsius.isSelected = false
        buttonFahrenheit.isSelected = true
        UserDefaultHelper.setTempratureUnit(unit: "F")
        self.tableView.reloadData()
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
        if(indexPath.row != 1 && indexPath.row != 2 && indexPath.row != 0) {
            return true
        } else {
            return false
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // handle delete, remove city name from weather list
            let cityID = weatherDataModel.weatherListArray[indexPath.row].id
            UserDefaultHelper.deleteSelectedCityFromUserDefault(cityID: cityID){
                self.getWeatherDataFromViewModel()
            }
        }
    }
}

