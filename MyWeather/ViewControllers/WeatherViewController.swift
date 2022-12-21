//
//  ViewController.swift
//  MyWeather
//
//  Created by Artem Pavlov on 10.12.2022.
//

import UIKit

class WeatherController: UITableViewController {
    
    private let cellID = "weatherCell"
    private var citiesList: [Weather] = []
    private var filteredCities: [Weather] = []
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else {return false}
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(WeatherViewCell.self, forCellReuseIdentifier: cellID)
        setupNavigationBar()
        setupSearchController()
        tableView.rowHeight = 70
        getWeatherForCity("Moscow")
        getWeatherForCity("London")
        getWeatherForCity("Spain")
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltering ? filteredCities.count : citiesList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! WeatherViewCell
        let city = isFiltering ? filteredCities[indexPath.row] : citiesList[indexPath.row]
        cell.configure(with: city)
        return cell
    }
    
    //MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let city = isFiltering ? filteredCities[indexPath.item] : citiesList[indexPath.item]
        let weatherDetailVC = WeatherDetailsViewController()
        weatherDetailVC.cityWeather = city
        show(weatherDetailVC, sender: nil)
    }
    
    private func setupNavigationBar() {
        title = "Weather"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func getWeatherForCity(_ city: String) {
        NetworkManager.shared.fetchData(for: city, from: URLManager.shared.getWeatherURL(forCity: city, forNumberOfDays: 8)) {
            result in
            switch result {
            case .success(let weather):
                self.citiesList.append(weather)
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

// MARK: - UISearchResultsUpdating
extension WeatherController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredCities = citiesList.filter { city in
            city.location.name.lowercased().contains(searchText.lowercased())
        }.sorted {$0.location.name < $1.location.name }
        tableView.reloadData()
    }
}

