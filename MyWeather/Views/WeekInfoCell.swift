//
//  WeekendInfoCell.swift
//  MyWeather
//
//  Created by Artem Pavlov on 21.12.2022.
//

import UIKit

class WeekInfoCell: UICollectionViewCell, SelfConfiguringCell {
    
    //MARK: - Static Properties
    static let reuseId: String = "weekendWeather"
    
    //MARK: - Private Properties
    private let dayLabel = UILabel()
    private let icon = UIImageView()
    private let chanceLabel = UILabel()
    private let highTempLabel = UILabel()
    private let lowTempLabel = UILabel()
    
    private lazy var chanceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.spacing = 8
        stackView.addArrangedSubview(icon)
        stackView.addArrangedSubview(chanceLabel)
        return stackView
    }()
    
    private lazy var tempStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.spacing = 8
        stackView.addArrangedSubview(lowTempLabel)
        stackView.addArrangedSubview(highTempLabel)
        return stackView
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.alignment = .fill
        stackView.addArrangedSubview(dayLabel)
        stackView.addArrangedSubview(chanceStackView)
        stackView.addArrangedSubview(tempStackView)
        return stackView
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElements(horizontalStackView, chanceStackView, tempStackView)
        setupSubViews(horizontalStackView, chanceStackView, tempStackView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Confirure cell    
    func configure(with data: Any) {
        guard let weatherData = data as? ForecastDay else { return }
        dayLabel.text = formatDate(weatherData.date, fromFormat: "yyyy-MM-dd", toFormat: "EEEE")
        fetchImage(from: weatherData.day.condition.icon)
        chanceLabel.text = chanceResult(with: weatherData.day.daily_chance_of_rain, andWith: weatherData.day.daily_chance_of_snow)
        highTempLabel.text = String(format:"%.0f", weatherData.day.maxtemp_c) + "°"
        lowTempLabel.text = String(format:"%.0f", weatherData.day.mintemp_c) + "°"
    }
    
    //MARK: - Private Methods
    private func formatDate(_ date: String, fromFormat: String, toFormat: String) -> String {
        var dateToOutput = ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat
        
        if let dateToConvert = dateFormatter.date(from: date) {
            let formatedDate = DateFormatter()
            formatedDate.dateFormat = toFormat
            dateToOutput = formatedDate.string(from: dateToConvert)
        }
        return dateToOutput
    }
    
    private func fetchImage(from url: String?) {
        let corectUrl = "https:" + url!
        DispatchQueue.global().async {
            
            guard let imageData = ImageManager.shared.loadImage(from: corectUrl) else {return}
            DispatchQueue.main.async {
                self.icon.image = UIImage(data: imageData)!
            }
        }
    }
    
    private func chanceResult(with dailyChanceOfRain: Int, andWith dailyChanceOfSnow: Int) -> String {
        var result = ""
        if dailyChanceOfRain == 0 {
            if dailyChanceOfSnow != 0 {
                result = "\(dailyChanceOfSnow)%"
            }
        } else {
            result = "\(dailyChanceOfRain)%"
        }
        return result
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        horizontalStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        horizontalStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        horizontalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        horizontalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        icon.heightAnchor.constraint(equalToConstant: 40).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        chanceStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        chanceStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        tempStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        tempStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        
    }
}
