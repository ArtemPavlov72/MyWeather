//
//  WindDescriptionCell.swift
//  MyWeather
//
//  Created by Artem Pavlov on 23.12.2022.
//

import UIKit

class WindDescriptionCell: UICollectionViewCell, SelfConfiguringCell {
    
    //MARK: - Static Properties
    static let reuseId: String = "textDescriptionOfDay"
    
    //MARK: - Private Properties
    private var descriptionWeatherLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .justified
        return label
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElements(descriptionWeatherLabel)
        setupSubViews(descriptionWeatherLabel)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Confirure cell
    func configure(with data: Any) {
        guard let weatherData = data as? CityWeatherData else { return }
        descriptionWeatherLabel.text = "Now, wind speed is about \(String(format:"%.0f",  weatherData.wind_kph / 3.6)) m/s. And gusts can change to \(String(format:"%.0f", weatherData.gust_kph / 3.6)) m/s."
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        descriptionWeatherLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        descriptionWeatherLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        descriptionWeatherLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        descriptionWeatherLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
    }
}
