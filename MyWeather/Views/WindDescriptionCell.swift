//
//  WindDescriptionCell.swift
//  MyWeather
//
//  Created by Artem Pavlov on 23.12.2022.
//

import UIKit

class WindDescriptionCell: UICollectionViewCell {
    
    //MARK: - Static Properties
    static let reuseId: String = "textDescriptionOfDay"
    
    //MARK: - Private Properties
    private var descriptionWeatherLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .justified
        return label
    }()
    
    private var backgroundColorView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.4)
        view.layer.cornerRadius = 8
        return view
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElements(descriptionWeatherLabel, backgroundColorView)
        setupSubViews(descriptionWeatherLabel, backgroundColorView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Confirure cell
    func configure(with windInfo: CityWeatherData) {
        descriptionWeatherLabel.text = "Now, wind speed is about \(String(format:"%.0f",  windInfo.wind_kph / 3.6)) m/s. And gusts can change to \(String(format:"%.0f", windInfo.gust_kph / 3.6)) m/s."
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        backgroundColorView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        backgroundColorView.heightAnchor.constraint(equalTo: self.heightAnchor, constant: 10).isActive = true
        
        descriptionWeatherLabel.centerXAnchor.constraint(equalTo: self.backgroundColorView.centerXAnchor).isActive = true
        descriptionWeatherLabel.centerYAnchor.constraint(equalTo: self.backgroundColorView.centerYAnchor).isActive = true
        descriptionWeatherLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        descriptionWeatherLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        
//        bottomLine.topAnchor.constraint(equalTo: self.descriptionWeatherLabel.bottomAnchor, constant: 8).isActive = true
//        bottomLine.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
//        bottomLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
//        bottomLine.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
//        bottomLine.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
    }
}
