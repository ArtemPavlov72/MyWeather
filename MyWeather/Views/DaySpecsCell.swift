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
    
    private var backgroundColorView: UIView = {
        let line = UIView()
        line.backgroundColor = .white.withAlphaComponent(0.4)
        line.layer.cornerRadius = 8
        return line
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.alignment = .center
        stackView.spacing = 3.0
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(valueLabel)
        return stackView
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
    func configure(with description: String, and value: String) {
        descriptionLabel.text = description
        valueLabel.text = value
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        backgroundColorView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        backgroundColorView.heightAnchor.constraint(equalTo: self.heightAnchor, constant: 40).isActive = true
        
        stackView.centerXAnchor.constraint(equalTo: self.backgroundColorView.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.backgroundColorView.centerYAnchor).isActive = true
    }
}
