//
//  AddCityViewModel.swift
//  Optus_POC
//
//  Created by Rohit on 12/21/20.
//

import Foundation
class AddCityViewModel {
    var completeCityList: [City] = [City]()
    var filteredCityList: [City] = [City]()
    
    /// method to read city data from locally stored JSON file
    func readCityDataFromJSON(completion: @escaping (Result<Bool, Error>) -> Void) {
        if let path = Bundle.main.path(forResource: "current.city.list", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                do {
                    let cityData = try decoder.decode([City].self, from: data)
                    completeCityList = cityData
                    print("Success")
                    completion(.success(true))
                } catch {
                    completion(.failure(error))
                }
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    /// method to filter city data by provoded string
    ///
    /// - Parameter string: string which will be used to search for city
    func filterCityDataWith(string: String,completion: @escaping () -> ()) {
        filteredCityList = completeCityList.filter { (city: City) -> Bool in
            return city.name.lowercased().contains(string.lowercased())
        }
        completion()
    }
    
    func getCityDataCount() -> Int {
        return completeCityList.count
    }
}
