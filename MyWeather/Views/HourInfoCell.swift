//
//  HourInfoCell.swift
//  MyWeather
//
//  Created by Artem Pavlov on 15.12.2022.
//

import UIKit

class HourInfoCell: UICollectionViewCell, SelfConfiguringCell {
    
    //MARK: - Static Properties
    static let reuseId: String = "hourWeather"
    
    //MARK: - Private Properties
    private let tempLabel = UILabel()
    private let timeLabel = UILabel()
    private let icon = UIImageView()
    
    private var backgroundColorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue.withAlphaComponent(0.1)
        view.layer.cornerRadius = 15
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.alignment = .center
        stackView.spacing = 5.0
        stackView.addArrangedSubview(timeLabel)
        stackView.addArrangedSubview(icon)
        stackView.addArrangedSubview(tempLabel)
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
    func configure(with data: Any) {
        guard let weatherData = data as? Hour else { return }
        fetchImage(from: weatherData.condition.icon)
        timeLabel.text = formatDate(weatherData.time, fromFormat: "yyyy-MM-dd HH:mm", toFormat: "h:mm a")
        tempLabel.text = String(format:"%.0f", weatherData.temp_c) + "°"
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
        backgroundColorView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        backgroundColorView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    
        stackView.centerXAnchor.constraint(equalTo: self.backgroundColorView.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.backgroundColorView.centerYAnchor).isActive = true
        
        icon.heightAnchor.constraint(equalToConstant: 40).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 40).isActive = true

    }
}
