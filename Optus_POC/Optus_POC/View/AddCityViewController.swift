//
//  AddCityViewController.swift
//  Optus_POC
//
//  Created by Rohit on 12/21/20.
//

import Foundation
import UIKit

class AddCityViewController: UITableViewController {
    
    let cityViewModel = AddCityViewModel()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("Add City", comment: "")
        self.view.backgroundColor = UIColor(red: 0/255, green: 197/255, blue: 246/255, alpha: 1)
        self.addActivityIndicator()
        setUpSearchViewController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(cityViewModel.getCityDataCount() == 0) {
            fetchCityData()
        } else {
            self.stopActivityIndicator()
        }
    }
    
    //MARK: - class private methods
    
    //method to fetch city data from locally stored JSON file
    private func fetchCityData() {
        cityViewModel.readCityDataFromJSON { response in
            self.stopActivityIndicator()
            switch(response) {
            case .success:
                print("Success")
            case .failure(let error):
                self.displayErrorMessageWith(messageString: error.localizedDescription)
            }
        }
    }
    
    /// Method to setup search view controller on view controller
    private func setUpSearchViewController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        if #available(iOS 13.0, *) {
            searchController.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("Search by city name", comment: ""),attributes: [NSAttributedString.Key.foregroundColor: UIColor.blue])
        } else {
            searchController.searchBar.placeholder = NSLocalizedString("Search by city name", comment: "")
        }
        searchController.searchBar.barTintColor = UIColor.init(red: 35.0/255, green: 163.0/255, blue: 229.0/255, alpha: 1)
        self.tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
    }
    
    //MARK: - Table view delegate and data source methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityViewModel.filteredCityList.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //saveSeclectedCityObject
        let lastCityObject = cityViewModel.filteredCityList[indexPath.row]
        UserDefaultHelper.saveSeclectedCityObject(cityData: lastCityObject){
            result in
            if result {
                self.navigationController?.popViewController(animated: true)
            } else {
                self.displayErrorMessageWith(messageString: NSLocalizedString("CityExistMessage", comment: ""))
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityTableViewCell", for: indexPath)
        cell.accessibilityIdentifier = "CityTableViewCell_\(indexPath.row)"

        let city = cityViewModel.filteredCityList[indexPath.row]
        cell.textLabel?.text = city.place
        return cell
    }
}

//MARK: - UISearchBar Delegate
extension AddCityViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        cityViewModel.filterCityDataWith(string: searchBar.text!) {
            self.tableView.reloadData()
        }
    }
}
