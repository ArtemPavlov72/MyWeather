//
//  SelfConfiguringCell.swift
//  MyWeather
//
//  Created by Артем Павлов on 24.03.2023.
//

import Foundation

protocol SelfConfiguringCell {
    static var reuseId: String { get }
    func configure(with data: Any)
}
