//
//  DaySpecsCell.swift
//  MyWeather
//
//  Created by Artem Pavlov on 25.12.2022.
//

import UIKit

class DaySpecsCell: UICollectionViewCell {

    static var reuseId: String = "weatherDaySpecs"
    
    private var descriptionLabel = UILabel()
    private var valueLabel = UILabel()
    
    
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
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configure(with description: String, and value: String) {
        descriptionLabel.text = description
        valueLabel.text = value
    }
    
}

// MARK: - Setup Constraints
extension DaySpecsCell {
    private func setupConstraints() {
        addSubview(descriptionLabel)
        addSubview(valueLabel)
        
        descriptionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        descriptionLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        valueLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        valueLabel.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 3).isActive = true
    }
}
