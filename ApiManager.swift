//
//  ApiManager.swift
//  SkyCast
//
//  Created by Owais on 12/11/24.
//

import Foundation

class ApiManager {
    static let shared = ApiManager()
    
    let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    let apiKey = "80ab534e79d834b85c057185b53226c9"
    
    func fetchCurrentWeather(for city: String, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        
        let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? city
        let urlString = "\(baseURL)?q=\(cityEncoded)&appid=\(apiKey)&units=metric"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                DispatchQueue.main.async {
//                    self.weatherLabel.text = "Failed to fetch weather data."
                    print("Failed to fetch weather data.")
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
//                    self.weatherLabel.text = "No data received."
                    print("No data received.")
                }
                return
            }
            
            do {
                let weatherData = try JSONDecoder().decode(WeatherResponse.self, from: data)
                completion(.success(weatherData))
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
