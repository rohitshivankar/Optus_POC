//
//  ViewController.swift
//  Optus_POC
//
//  Created by Rohit on 12/20/20.
//

import UIKit

class WeatherListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        self.title = NSLocalizedString("Weather", comment: "")
        self.tableView.accessibilityIdentifier = "Table-WeatherListTableView"
    }
    
    //MARK: - Table view delegate and data source methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell") as! WeatherTableViewCell
        cell.cityName.text = "Pune"
        cell.cityTemperature.text = "32"
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

