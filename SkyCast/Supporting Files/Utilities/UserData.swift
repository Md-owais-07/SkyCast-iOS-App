//
//  UswerData.swift
//  SkyCast
//
//  Created by Owais on 12/11/24.
//

import Foundation

class UserData {
    static let shared = UserData()
    private let userDefault = UserDefaults.standard
    
    var isNewUser: Bool {
        get {
            userDefault.bool(forKey: "isNewUser")
        }
        set(status) {
            userDefault.set(status, forKey: "isNewUser")
        }
    }
}
