//
//  ViewController.swift
//  MyWeather
//
//  Created by Artem Pavlov on 10.12.2022.
//

import UIKit

class WeatherController: UITableViewController {
    
    //MARK: - Private Properties
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
    
    //MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: WeatherTableViewCell.reuseId)
        
        setupSearchController()
        tableView.rowHeight = 70
        getWeatherForCity("Moscow", "London", "Spain", "Surgut", "Tyumen", "Tbilisi", "Kazan", "Berlin", "Paris", "Sofia")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupNavigationBar()
    }
    
    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltering ? filteredCities.count : citiesList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.reuseId, for: indexPath) as! WeatherTableViewCell
        let city = isFiltering ? filteredCities[indexPath.row] : citiesList[indexPath.row]
        cell.configure(with: city)
        return cell
    }
    
    //MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let city = isFiltering ? filteredCities[indexPath.item] : citiesList[indexPath.item]
        let weatherDetailVC = WeatherDetailsViewController()
        weatherDetailVC.weather = city
        show(weatherDetailVC, sender: nil)
    }
    
    //MARK: - Private Methods
    private func setupNavigationBar() {
        title = "Weather"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func getWeatherForCity(_ cities: String...) {
        cities.forEach { city in
            NetworkManager.shared.fetchData(for: city, from: Links.getWeatherURL(forCity: city, forNumberOfDays: 3)) {
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

