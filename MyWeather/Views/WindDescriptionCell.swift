//
//  WindDescriptionCell.swift
//  MyWeather
//
//  Created by Artem Pavlov on 23.12.2022.
//

import UIKit

class WindDescriptionCell: UICollectionViewCell {
    
    //MARK: - Static Properties
    static var reuseId: String = "textDescriptionOfDay"
    
    //MARK: - Private Properties
    private var descriptionWeatherLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElements()
        setupSubViews(descriptionWeatherLabel)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Confirure cell
    func configure(with windInfo: CityWeatherData) {
        descriptionWeatherLabel.text = "Now, wind speed is \(String(format:"%.0f",  windInfo.wind_kph / 3.6)) m/s. And gusts can change to \(String(format:"%.0f", windInfo.gust_kph / 3.6)) m/s."
    }
    
    //MARK: - Private Methods
    private func setupElements() {
        descriptionWeatherLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupSubViews(_ subViews: UIView...) {
        subViews.forEach { subview in
            self.addSubview(subview)
        }
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        descriptionWeatherLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        descriptionWeatherLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        descriptionWeatherLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
    }
}
