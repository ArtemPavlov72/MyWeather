//
//  NetworkManager.swift
//  MyWeather
//
//  Created by Artem Pavlov on 11.12.2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func fetchData(for city: String, from url: String, completion: @escaping(Result<Weather, NetworkError>) -> Void) {
        guard let url = URL(string: url + city) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "no description")
                return
            }
            
            do {
                let weather = try JSONDecoder().decode(Weather.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(weather))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        } .resume()
    }
}

class ImageManager {
    static let shared = ImageManager()
    private init() {}
    
    func loadImage(from url: String?) -> Data? {
        guard let imageURL = URL(string: url ?? "") else {return nil}
        return try? Data(contentsOf: imageURL)
    }
}
