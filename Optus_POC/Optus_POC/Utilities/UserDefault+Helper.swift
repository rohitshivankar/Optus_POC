//
//  UserDefault+Helper.swift
//  Optus_POC
//
//  Created by Rohit on 12/20/20.
//

import Foundation
import UIKit

class UserDefaultHelper {
    
    //one time setup for initial cities, method will be used to store defaut cities which will be displayed on weather list screen and also to store default temp unit
    static func saveDefaultCities(){
        let userDefaults = UserDefaults.standard
        if (userDefaults.value(forKey: "InitialLoad") != nil) {
            print("This is not a first time load")
        } else {
            UserDefaults.standard.set(true, forKey: "InitialLoad")
            UserDefaults.standard.set("2158177,2147714,2174003", forKey: "CityData")
            UserDefaults.standard.set("C", forKey: "DefaultUnit")
        }
    }
    
     /// Method to get all saved cities from user default
    static func getAllSecletdCitieIDs() -> String {
        let userDefaults = UserDefaults.standard
        if let cityData = userDefaults.value(forKey: "CityData") {
            return cityData as! String
        } else {
            return ""
        }
    }
    
    /// Method to delete selected city from user default
    ///
    /// - Parameter cityID: ID which will be deleted from user default
    static func deleteSelectedCityFromUserDefault(cityID: Int,completion: () -> ()){
        var savedCityData = UserDefaultHelper.getAllSecletdCitieIDs()
        if(savedCityData.contains(String(cityID))) {
            savedCityData = savedCityData.replacingOccurrences(of: String(cityID), with: "")
            if(savedCityData.contains(String(",,"))) {
                savedCityData = savedCityData.replacingOccurrences(of: ",,", with: ",")
            }
            let characterSet = CharacterSet.init(charactersIn: ",")
            savedCityData = savedCityData.trimmingCharacters(in: characterSet)
        }
        UserDefaults.standard.set(savedCityData, forKey: "CityData")
        completion()
    }
    
    /// Method to set temp unit on user default
    ///
    /// - Parameter unit: String to be saved in user default
    static func setTempratureUnit(unit: String){
        UserDefaults.standard.set(unit, forKey: "DefaultUnit")
    }
    
    /// Method to get temp unit from user default
    static func getTempratureUnit() -> String{
        let defaultUnit = UserDefaults.standard
        return defaultUnit.value(forKey: "DefaultUnit") as! String
    }
    
    /// Method to save selected city ID into user default
    ///
    /// - Parameter cityData: cityData object from which we can retrive the cityID whcih will be stored in user default
    static func saveSeclectedCityObject(cityData: City,completion: (Bool) -> Void){
        var savedCityData = getAllSecletdCitieIDs()
        if(savedCityData.contains(String(cityData.id))) {
            completion(false)
        } else {
            if savedCityData != "" {
                savedCityData += ","
            }
            savedCityData += String(cityData.id)
            UserDefaults.standard.set(savedCityData, forKey: "CityData")
            completion(true)
        }
    }
    
}
