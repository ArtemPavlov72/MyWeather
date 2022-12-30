//
//  WeekendInfoCell.swift
//  MyWeather
//
//  Created by Artem Pavlov on 21.12.2022.
//

import UIKit

class WeekInfoCell: UICollectionViewCell {
    
    //MARK: - Static Properties
    static let reuseId: String = "weekendWeather"
    
    //MARK: - Private Properties
    private let dayLabel = UILabel()
    private let icon = UIImageView()
    private let chanceLabel = UILabel()
    private let highTempLabel = UILabel()
    private let lowTempLabel = UILabel()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElements(dayLabel, icon, chanceLabel, highTempLabel, lowTempLabel)
        setupSubViews(dayLabel, icon, chanceLabel, highTempLabel, lowTempLabel)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Confirure cell
    func configure(with forecast: ForecastDay) {
        dayLabel.text = formatDate(forecast.date, fromFormat: "yyyy-MM-dd", toFormat: "EEEE")
        fetchImage(from: forecast.day.condition.icon)
        chanceLabel.text = chanceResult(with: forecast.day.daily_chance_of_rain, andWith: forecast.day.daily_chance_of_snow)
        highTempLabel.text = String(format:"%.0f", forecast.day.maxtemp_c) + "°"
        lowTempLabel.text = String(format:"%.0f", forecast.day.mintemp_c) + "°"
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
            if dailyChanceOfSnow == 0 {
                result = ""
            } else {
                result = "\(dailyChanceOfSnow)%"
            }
        } else {
            result = "\(dailyChanceOfRain)%"
        }
        return result
    }
    
    private func setupElements(_ subViews: UIView...) {
        subViews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupSubViews(_ subViews: UIView...) {
        subViews.forEach { self.addSubview($0)
        }
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        dayLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        dayLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        dayLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        
        icon.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -20).isActive = true
        icon.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 30).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        chanceLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 20).isActive = true
        chanceLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        highTempLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40).isActive = true
        highTempLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        lowTempLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        lowTempLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
