//
//  Header.swift
//  MyWeather
//
//  Created by Артем Павлов on 21.03.2023.
//

import UIKit

class Header: UICollectionReusableView {
    
    static let reuseId: String = "headerSectionId"
   
    let title = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        title.textColor = .label
        title.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 22, weight: .bold))
        
        title.translatesAutoresizingMaskIntoConstraints = false
        addSubview(title)
        
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: leadingAnchor),
            title.trailingAnchor.constraint(equalTo: trailingAnchor),
            title.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            title.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Stop trying to make storyboards happen.")
    }
}

