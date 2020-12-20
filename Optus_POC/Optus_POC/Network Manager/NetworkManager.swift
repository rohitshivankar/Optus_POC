//
//  NetworkManager.swift
//  Optus_POC
//
//  Created by Rohit on 12/20/20.
//

import Foundation

class NetworkManager {
    
    static let sharedInstance = NetworkManager()
    
    /// Method to get data from webservice
    ///
    /// - Parameter urlString: URL whihc will be used to make get request call
    func getDataFromWebService<T: Decodable>(urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let webServiceURL = URL.init(string: urlString) else { return }
        URLSession.shared.dataTask(with: webServiceURL) { (data, response, error) in
            if let errorObject = error {
                print(errorObject)
                completion(.failure(errorObject))
            } else {
                guard let data = data else { return }
                print(data)
                let jsonString = String(decoding: data, as: UTF8.self)
                do {
                    print(jsonString)
                    let responseData = try JSONDecoder().decode(T.self, from: jsonString.data(using: .utf8)!)
                    completion(.success(responseData))
                } catch {
                    print(error)
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
