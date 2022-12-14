//
//  HourInfoCell.swift
//  MyWeather
//
//  Created by Artem Pavlov on 15.12.2022.
//

import UIKit

class HourInfoCell: UICollectionViewCell {
    
    //MARK: - Static Properties
    static let reuseId: String = "hourWeather"
    
    //MARK: - Private Properties
    private let tempLabel = UILabel()
    private let timeLabel = UILabel()
    private let icon = UIImageView()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElements(timeLabel, tempLabel, icon)
        setupSubViews(timeLabel, tempLabel, icon)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Confirure cell
    func configure(with hourWeather: Hour) {
        fetchImage(from: hourWeather.condition.icon)
        timeLabel.text = formatDate(hourWeather.time, fromFormat: "yyyy-MM-dd HH:mm", toFormat: "h:mm a")
        tempLabel.text = String(format:"%.0f", hourWeather.temp_c) + "°"
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
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        timeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        timeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        icon.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        icon.topAnchor.constraint(equalTo: self.timeLabel.bottomAnchor, constant: 8).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 30).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        tempLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        tempLabel.topAnchor.constraint(equalTo: self.icon.bottomAnchor, constant: 8).isActive = true
    }
}
