//
//  TextDescriptionOfDayCell.swift
//  MyWeather
//
//  Created by Artem Pavlov on 23.12.2022.
//

import UIKit

class TextDescriptionOfDayCell: UICollectionViewCell {

    static var reuseId: String = "textDescriptionOfDay"
    
    private var descriptionLabel: UILabel = {
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
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configure(with currentData: CityWeatherData) {
        descriptionLabel.text = "Now, wind speed is \(String(format:"%.0f", currentData.wind_kph / 3.6)) m/s. And gusts can up to \(String(format:"%.0f", currentData.gust_kph / 3.6)) m/s."
    }
}

// MARK: - Setup Constraints
extension TextDescriptionOfDayCell {
    private func setupConstraints() {
        addSubview(descriptionLabel)
        
        descriptionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        descriptionLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
    }
}
