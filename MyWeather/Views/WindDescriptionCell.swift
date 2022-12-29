//
//  WindDescriptionCell.swift
//  MyWeather
//
//  Created by Artem Pavlov on 23.12.2022.
//

import UIKit

class WindDescriptionCell: UICollectionViewCell {

    static var reuseId: String = "textDescriptionOfDay"
    
    private var descriptionWeatherLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElements()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupElements() {
        descriptionWeatherLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configure(with windInfo: CityWeatherData) {
        descriptionWeatherLabel.text = "Now, wind speed is \(String(format:"%.0f",  windInfo.wind_kph / 3.6)) m/s. And gusts can change to \(String(format:"%.0f", windInfo.gust_kph / 3.6)) m/s."
    }
}

// MARK: - Setup Constraints
extension WindDescriptionCell {
    private func setupConstraints() {
        addSubview(descriptionWeatherLabel)
        
        descriptionWeatherLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        descriptionWeatherLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        descriptionWeatherLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
    }
}
