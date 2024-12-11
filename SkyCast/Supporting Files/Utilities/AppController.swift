//
//  AppController.swift
//  SkyCast
//
//  Created by Owais on 12/11/24.
//

import Foundation
import UIKit

class AppStoryboard {
    static let shared = AppStoryboard()
    
    var main: UIStoryboard {
        UIStoryboard(name: "Main", bundle: nil)
    }
}

class AppController {
    static let shared = AppController()
    
    var home: HomeVC {
        AppStoryboard.shared.main.instantiateViewController(withIdentifier: "HomeVC_id") as? HomeVC ?? HomeVC()
    }
    var onboardin: OnboardingVC {
        AppStoryboard.shared.main.instantiateViewController(withIdentifier: "OnboardingVC_id") as? OnboardingVC ?? OnboardingVC()
    }
}
