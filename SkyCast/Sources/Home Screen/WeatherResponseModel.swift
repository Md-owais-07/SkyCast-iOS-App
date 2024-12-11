//
//  WeatherResponseModel.swift
//  SkyCast
//
//  Created by Owais on 12/11/24.
//

import Foundation

struct WeatherResponse: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let wind: Wind
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let humidity: Int
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
}


//struct WeatherResponse: Codable {
//    let coord: Coordinates
//    let weather: [Weather]
//    let base: String?
//    let main: Main
//    let visibility: Int?
//    let wind: Wind
//    let clouds: Clouds
//    let dt: Int
//    let sys: System
//    let timezone: Int
//    let id: Int
//    let name: String
//    let cod: Int
//}
//
//struct Coordinates: Codable {
//    let lon: Double
//    let lat: Double
//}
//
//struct Weather: Codable {
//    let id: Int
//    let main: String
//    let description: String
//    let icon: String
//}
//
//struct Main: Codable {
//    let temp: Double
//    let feelsLike: Double
//    let tempMin: Double
//    let tempMax: Double
//    let pressure: Int
//    let humidity: Int
//    let seaLevel: Int?
//    let grndLevel: Int?
//    
//    enum CodingKeys: String, CodingKey {
//        case temp
//        case feelsLike = "feels_like"
//        case tempMin = "temp_min"
//        case tempMax = "temp_max"
//        case pressure
//        case humidity
//        case seaLevel = "sea_level"
//        case grndLevel = "grnd_level"
//    }
//}
//
//struct Wind: Codable {
//    let speed: Double
//    let deg: Int?
//}
//
//struct Clouds: Codable {
//    let all: Int?
//}
//
//struct System: Codable {
//    let type: Int?
//    let id: Int
//    let country: String
//    let sunrise: Int
//    let sunset: Int
//}
