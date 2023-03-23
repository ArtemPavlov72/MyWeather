//
//  RoundedBackgroundView.swift
//  MyWeather
//
//  Created by Артем Павлов on 23.03.2023.
//

import UIKit

class RoundedBackgroundView: UICollectionReusableView {
    
    static let reuseId: String = "backgroundView"
    
    private var insetView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemYellow
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        addSubview(insetView)
        
        NSLayoutConstraint.activate([
            insetView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            trailingAnchor.constraint(equalTo: insetView.trailingAnchor, constant: 8),
            insetView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            insetView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
