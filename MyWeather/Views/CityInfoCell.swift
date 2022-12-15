//
//  CityInfoCell.swift
//  MyWeather
//
//  Created by Artem Pavlov on 14.12.2022.
//

import UIKit

class CityInfoCell: UICollectionViewCell {
    
    static var reuseId: String = "CityCell"
    
    let cityName = UILabel()
    let tempLabel = UILabel()
    let conditionLabel = UILabel()
    let highTempLabel = UILabel()
    let lowTempLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(white: 1, alpha: 1)
        setupElements()
        setupConstraints()

        self.layer.cornerRadius = 4
        self.clipsToBounds = true
    }
    
    func setupElements() {
        cityName.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        conditionLabel.translatesAutoresizingMaskIntoConstraints = false
        highTempLabel.translatesAutoresizingMaskIntoConstraints = false
        lowTempLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configure(with city: Weather) {
        cityName.text = city.location.name
        tempLabel.text = city.current.temp_c.description + "°"
        conditionLabel.text = city.current.condition.text
        
        guard let forecastForDay = city.forecast.forecastday.first else {return}
        highTempLabel.text = "H: " + String(describing:forecastForDay.day.maxtemp_c) + "°"
        lowTempLabel.text = "L: " + String(describing:forecastForDay.day.mintemp_c) + "°"

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Constraints
extension CityInfoCell {
    func setupConstraints() {
        addSubview(cityName)
        addSubview(tempLabel)
        addSubview(conditionLabel)
        addSubview(highTempLabel)
        addSubview(lowTempLabel)
        
        cityName.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        cityName.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        
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
