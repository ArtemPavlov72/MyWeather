//
//  UIViewCell.swift
//  MyWeather
//
//  Created by Artem Pavlov on 30.12.2022.
//

import UIKit

extension UICollectionViewCell {
    func setupElements(_ subViews: UIView...) {
        subViews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setupSubViews(_ subViews: UIView...) {
        subViews.forEach { self.addSubview($0)
        }
    }
}
