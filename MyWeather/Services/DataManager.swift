//
//  DataManager.swift
//  MyWeather
//
//  Created by Артем Павлов on 25.03.2023.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    
    private init() {}
    
    func createStartListOfCities() -> [String] {
        return ["Moscow", "London", "Spain"]
    }
}
