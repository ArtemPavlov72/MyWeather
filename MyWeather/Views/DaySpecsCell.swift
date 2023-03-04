//
//  DaySpecsCell.swift
//  MyWeather
//
//  Created by Artem Pavlov on 25.12.2022.
//

import UIKit

class DaySpecsCell: UICollectionViewCell {
    
    //MARK: - Static Properties
    static let reuseId: String = "weatherDaySpecs"
    
    //MARK: - Private Properties
    private var descriptionLabel = UILabel()
    private var valueLabel = UILabel()
    
    private var bottomLine: UIView = {
        let line = UIView()
        line.backgroundColor = .systemGray5
        return line
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElements(descriptionLabel, valueLabel, bottomLine)
        setupSubViews(descriptionLabel, valueLabel, bottomLine)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Confirure cell
    func configure(with description: String, and value: String) {
        descriptionLabel.text = description
        valueLabel.text = value
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        descriptionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        descriptionLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        valueLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        valueLabel.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 3).isActive = true
        
        bottomLine.topAnchor.constraint(equalTo: self.valueLabel.bottomAnchor, constant: 0).isActive = true
        bottomLine.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        bottomLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
}
