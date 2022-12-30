//
//  WeatherViewCell.swift
//  MyWeather
//
//  Created by Artem Pavlov on 11.12.2022.
//

import UIKit

class WeatherViewCell: UITableViewCell {
    
    //MARK: - Static Properties
    static var reuseId: String = "weatherCell"

    //MARK: - Private Properties
    private let cityName = UILabel()
    private let temp = UILabel()
    private let picture = UIImageView()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubViews(cityName, temp, picture)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Confirure cell
    func configure(with city: Weather) {
        cityName.text = city.location.name
        temp.text = String(describing: city.current.temp_c) + "°"
        fetchImage(from: city.current.condition.icon)
    }
    
    //MARK: - Private Methods
    private func fetchImage(from url: String?) {
        let corectUrl = "https:" + url!
        DispatchQueue.global().async {
            
            guard let imageData = ImageManager.shared.loadImage(from: corectUrl) else { return }
            DispatchQueue.main.async {
                self.picture.image = UIImage(data: imageData)!
            }
        }
    }
    
    private func setupSubViews(_ subViews: UIView...) {
        subViews.forEach { subview in
            self.addSubview(subview)
        }
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        cityName.translatesAutoresizingMaskIntoConstraints = false
        temp.translatesAutoresizingMaskIntoConstraints = false
        picture.translatesAutoresizingMaskIntoConstraints = false
        
        cityName.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        cityName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        
        temp.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
        
        picture.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        picture.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
