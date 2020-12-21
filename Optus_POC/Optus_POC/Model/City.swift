//
//  City.swift
//  Optus_POC
//
//  Created by Rohit on 12/21/20.
//

import Foundation

struct City: Decodable, Identifiable {
    let id: Int
    let name, country: String
    
    var place: String {
        return "\(name), \(country)"
    }
}
