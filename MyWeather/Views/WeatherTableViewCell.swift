//
//  WeatherViewCell.swift
//  MyWeather
//
//  Created by Artem Pavlov on 11.12.2022.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
      
    //MARK: - Static Properties
    static let reuseId: String = "weatherCell"

    //MARK: - Private Properties
    private let cityName = UILabel()
    private let temp = UILabel()
    private let picture = UIImageView()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupElements(cityName, temp, picture)
        setupSubViews(cityName, temp, picture)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Confirure cell
    func configure(with data: Any) {
        if let city = data as? Weather {
            cityName.text = city.location.name
            temp.text = String(describing: city.current.temp_c) + "°"
            fetchImage(from: city.current.condition.icon)
        } else {
            guard let city = data as? CityLocationData else { return }
            cityName.text = "\(city.name), \(city.country)"
            temp.text = nil
            picture.image = nil
        }
    }
    
    //MARK: - Private Methods
    private func fetchImage(from url: String?) {
        let corectUrl = "https:" + url!
        DispatchQueue.global().async {
            
            guard let imageData = ImageManager.shared.loadImage(from: corectUrl) else { return }
            DispatchQueue.main.async {
                self.picture.image = UIImage(data: imageData)
            }
        }
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
        cityName.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        cityName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        
        temp.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
        
        picture.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        picture.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
