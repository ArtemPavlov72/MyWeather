//
//  ImageManager.swift
//  MyWeather
//
//  Created by Artem Pavlov on 29.12.2022.
//

import Foundation

class ImageManager {
    static let shared = ImageManager()
    private init() {}
    
    func loadImage(from url: String?) -> Data? {
        guard let imageURL = URL(string: url ?? "") else {return nil}
        return try? Data(contentsOf: imageURL)
    }
}
