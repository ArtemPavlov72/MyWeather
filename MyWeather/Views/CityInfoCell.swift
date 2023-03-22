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
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.alignment = .center
        stackView.spacing = 5.0
        stackView.addArrangedSubview(lowTempLabel)
        stackView.addArrangedSubview(highTempLabel)
        return stackView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.alignment = .center
        stackView.spacing = 8.0
        stackView.addArrangedSubview(cityName)
        stackView.addArrangedSubview(tempLabel)
        stackView.addArrangedSubview(conditionLabel)
        stackView.addArrangedSubview(horizontalStackView)
        return stackView
    }()
    
    private var backgroundColorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue.withAlphaComponent(0.1)
        view.layer.cornerRadius = 8
        return view
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElements(stackView, backgroundColorView)
        setupSubViews(stackView, backgroundColorView)
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
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        backgroundColorView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        backgroundColorView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        stackView.centerXAnchor.constraint(equalTo: self.backgroundColorView.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.backgroundColorView.centerYAnchor).isActive = true
        
        
//        cityName.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//        cityName.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
//
//        tempLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//        tempLabel.topAnchor.constraint(equalTo: self.cityName.bottomAnchor, constant: 8).isActive = true
//
//        conditionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//        conditionLabel.topAnchor.constraint(equalTo: self.tempLabel.bottomAnchor, constant: 8).isActive = true
//
//
//
//        highTempLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -40).isActive = true
//        highTempLabel.topAnchor.constraint(equalTo: self.conditionLabel.bottomAnchor).isActive = true
//
//        lowTempLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 40).isActive = true
//        lowTempLabel.topAnchor.constraint(equalTo: self.conditionLabel.bottomAnchor).isActive = true
    }
}
