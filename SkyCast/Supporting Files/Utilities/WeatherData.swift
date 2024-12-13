//
//  UswerData.swift
//  SkyCast
//
//  Created by Owais on 12/11/24.
//

import Foundation

class WeatherData {
    static let shared = WeatherData()
    private let userDefault = UserDefaults.standard
    
    var isNewUser: Bool {
        get {
            userDefault.bool(forKey: "isNewUser")
        }
        set(status) {
            userDefault.set(status, forKey: "isNewUser")
        }
    }
    
    var cityName: String {
        get {
            userDefault.string(forKey: "cityName") ?? ""
        }
        set(status) {
            userDefault.set(status, forKey: "cityName")
        }
    }
    
    var currentCity: String {
        get {
            userDefault.string(forKey: "currentCity") ?? ""
        }
        set(status) {
            userDefault.set(status, forKey: "currentCity")
        }
    }
}
