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
    private var filteredCities: [CityLocationData] = []
    
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
        setupNavigationBar()
        setupSearchController()
        tableView.rowHeight = 70
        getListOfWeather()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateNavigationBar()
    }
    
    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltering ? filteredCities.count : citiesList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.reuseId, for: indexPath) as! WeatherTableViewCell
        
        let city: Any = isFiltering ? filteredCities[indexPath.row] : citiesList[indexPath.row]
        cell.configure(with: city)
        
        return cell
    }
    
    //MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if isFiltering {
            var serchingWC: Weather?
            guard let city = filteredCities[indexPath.row].url else { return }
            
            NetworkManager.shared.fetchData(for: city, from: Links.getWeatherURL(forCity: city, forNumberOfDays: 3)) {
                result in
                switch result {
                case .success(let weather):
                    serchingWC = weather
                    let weatherDetailVC = WeatherDetailsViewController()
                    weatherDetailVC.weather = serchingWC
                    self.present(weatherDetailVC, animated: true)
                case .failure(let error):
                    print(error)
                }
            }
        } else {
            let city = citiesList[indexPath.item]
            let weatherDetailVC = WeatherDetailsViewController()
            weatherDetailVC.weather = city
            show(weatherDetailVC, sender: nil)
        }
    }
    
    //MARK: - Private Methods
    private func setupNavigationBar() {
        title = "Weather"
        navigationItem.largeTitleDisplayMode = .always
    }
    
    private func updateNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func getListOfWeather() {
        if !UserDefaults.standard.bool(forKey: "notFirstEnter") {
            getWeatherForCity(DataManager.shared.createStartListOfCities())
            UserDefaults.standard.set(true, forKey: "notFirstEnter")
        } else {
            getWeatherForCity(["Surgut"])
        }
    }
    
    private func getWeatherForCity(_ cities: [String]) {
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
    
    
    private func getWeatherForSearch(city: String) {
        NetworkManager.shared.fetchSearchingData(for: city, from: Links.geSearchURL()) {
            result in
            switch result {
            case .success(let weather):
                self.filteredCities = weather
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
        if !searchBarIsEmpty {
            guard let text = searchController.searchBar.text else { return }
            filterContentForSearchText(text)
        }
        if !isFiltering {
            self.tableView.reloadData()
        }
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        getWeatherForSearch(city: searchText)
    }
}
