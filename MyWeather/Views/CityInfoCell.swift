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
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElements(stackView)
        setupSubViews(stackView)
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
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
