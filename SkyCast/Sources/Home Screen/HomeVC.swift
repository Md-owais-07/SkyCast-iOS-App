//
//  MainWeatherVC.swift
//  SkyCast
//
//  Created by Owais on 12/11/24.
//

import UIKit

class HomeVC: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var searchView: UIView!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var weatherView: UIView!
    @IBOutlet weak var forecastView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var topSearchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var imageLogo: UIImageView!
    @IBOutlet weak var tempretureLbl: UILabel!
    @IBOutlet weak var temratureDayLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        searchView.layer.cornerRadius = 16
        detailsView.backgroundColor = .black.withAlphaComponent(0.1)
        detailsView.layer.cornerRadius = 16
        
        weatherView.backgroundColor = .black.withAlphaComponent(0.1)
        weatherView.layer.cornerRadius = 16
        
        forecastView.backgroundColor = .black.withAlphaComponent(0.1)
        forecastView.layer.cornerRadius = 16
        addGradientBackground()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Update gradient layer frame on layout changes
        if let gradientLayer = mainView.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = mainView.bounds
        }
    }
    
    func addGradientBackground() {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [
            
            // SKY CAST
            //            #colorLiteral(red: 1, green: 0.783536441, blue: 0, alpha: 1).cgColor,
            //            #colorLiteral(red: 0.09301672131, green: 0.08545271307, blue: 0.2453529537, alpha: 0.896577381).cgColor,
            
            // RAIN CAST
            #colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 1).cgColor,
            #colorLiteral(red: 0.09301672131, green: 0.08545271307, blue: 0.2453529537, alpha: 0.896577381).cgColor,
            
            //            // CLOUDY CAST
            //            #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1).cgColor,
            //            #colorLiteral(red: 0.09301672131, green: 0.08545271307, blue: 0.2453529537, alpha: 0.896577381).cgColor,
        ]
        
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        gradientLayer.frame = mainView.bounds
        
        mainView.layer.insertSublayer(gradientLayer, at: 0)
    }

}
