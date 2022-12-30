//
//  CityInfoCell.swift
//  MyWeather
//
//  Created by Artem Pavlov on 14.12.2022.
//

import UIKit

class CityInfoCell: UICollectionViewCell {
    
    //MARK: - Static Properties
    static let reuseId: String = "cityInfo"
    
    //MARK: - Private Properties
    private let cityName = UILabel()
    private let tempLabel = UILabel()
    private let conditionLabel = UILabel()
    private let highTempLabel = UILabel()
    private let lowTempLabel = UILabel()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElements()
        setupSubViews(cityName, tempLabel, conditionLabel, highTempLabel, lowTempLabel)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Confirure cell
    func configure(with city: Weather) {
        cityName.text = city.location.name
        tempLabel.text = city.current.temp_c.description + "°"
        conditionLabel.text = city.current.condition.text
        
        guard let forecastForDay = city.forecast.forecastday.first else {return}
        highTempLabel.text = "H: " + String(describing:forecastForDay.day.maxtemp_c) + "°"
        lowTempLabel.text = "L: " + String(describing:forecastForDay.day.mintemp_c) + "°"
    }
    
    //MARK: - Private Methods
    private func setupElements() {
        cityName.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        conditionLabel.translatesAutoresizingMaskIntoConstraints = false
        highTempLabel.translatesAutoresizingMaskIntoConstraints = false
        lowTempLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupSubViews(_ subViews: UIView...) {
        subViews.forEach { subview in
            self.addSubview(subview)
        }
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        cityName.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        cityName.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        tempLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        tempLabel.topAnchor.constraint(equalTo: self.cityName.bottomAnchor, constant: 8).isActive = true
        
        conditionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        conditionLabel.topAnchor.constraint(equalTo: self.tempLabel.bottomAnchor, constant: 8).isActive = true
        
        highTempLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -40).isActive = true
        highTempLabel.topAnchor.constraint(equalTo: self.conditionLabel.bottomAnchor).isActive = true
        
        lowTempLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 40).isActive = true
        lowTempLabel.topAnchor.constraint(equalTo: self.conditionLabel.bottomAnchor).isActive = true
    }
}
