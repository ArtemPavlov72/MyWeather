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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(WeatherViewCell.self, forCellReuseIdentifier: cellID)
        setupNavigationBar()
        tableView.rowHeight = 70
        getWeatherForCity("Moscow")
        getWeatherForCity("London")
        getWeatherForCity("Spain")
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? 0 : citiesList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! WeatherViewCell
        if indexPath.section == 1 {
            let city = citiesList[indexPath.row]
            cell.configure(with: city)
        }
        return cell
    }
    
    private func setupNavigationBar() {
        title = "Weather"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func getWeatherForCity(_ city: String) {
        NetworkManager.shared.fetchData(for: city, from: WeatherUrls.init().searchCityURL) {
            result in
            switch result {
            case .success(let weather):
                self.citiesList.append(weather)
                self.tableView.reloadData()
                print("\(weather)")
            case .failure(let error):
                print(error)
            }
        }
    }
}

