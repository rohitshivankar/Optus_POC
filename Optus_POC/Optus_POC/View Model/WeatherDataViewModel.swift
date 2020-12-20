//
//  WeatherDataViewModel.swift
//  Optus_POC
//
//  Created by Rohit on 12/20/20.
//

import Foundation
class WeatherDataViewModel {
    var weatherListArray: [Weather] = [Weather]()
    var weatherListCount: Int = 0
    
    /// Method to initiate web service call to retrive weather data for saved cities
    ///
    /// - Parameter completion: completion handlor to manage and return response from service
    func getWeatherForCitiesList(completion: @escaping (Result<Bool, Error>) -> Void) {
        var urlString = Constant.getWeatherListForGroupURL
        let selectedCityIDs = UserDefaultHelper.getAllSecletdCitieIDs()
        if (selectedCityIDs != "") {
            urlString = urlString + selectedCityIDs
        }
        print(urlString)
        NetworkManager.sharedInstance.getDataFromWebService(urlString: urlString){ (responseData: Result<WeatherReponse,Error>) in
            DispatchQueue.main.async {
                switch(responseData) {
                case .success(let responseWeatherList):
                    self.weatherListArray = responseWeatherList.list
                    self.weatherListCount = responseWeatherList.cnt
                    print(self.weatherListArray)
                    completion(.success(true))
                case.failure(let error):
                    print(error)
                    completion(.failure(error))
                }
            }
        }
    }

}
