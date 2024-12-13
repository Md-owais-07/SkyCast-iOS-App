//
//  MainWeatherVC.swift
//  SkyCast
//
//  Created by Owais on 12/11/24.
//

import UIKit

class HomeVC: UIViewController {
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
    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var lblUVIndex: UILabel!
    @IBOutlet weak var lblWindSpeed: UILabel!
    @IBOutlet weak var btnGotoSearch: UIButton!
    @IBOutlet weak var lblLocationName: UILabel!
    @IBOutlet weak var weatherAnimationView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        fetchdata()
        configureBackground()
        HideKeyboardWhenTapAround()
        
        searchTextField.delegate = self
        searchTextField.attributedPlaceholder = NSAttributedString(string: "Search City...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchdata()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let gradientLayer = mainView.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = mainView.bounds
        }
    }
    
    func fetchdata() {
        let cityName = searchTextField.text ?? ""
        
        if cityName.isEmpty && cityName == "" {
            print("AUOMATICALLY SELECTED CITY")
            ApiManager.shared.fetchCurrentWeather(for: WeatherData.shared.currentCity) { result in
                DispatchQueue.main.async {
                    switch result {
                    case.success(let response):
                        print("SUCCESS: \(response.name)")
                        self.update(with: response)
                    case.failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        } else {
            print("BY SEARCHING CITY")
            ApiManager.shared.fetchCurrentWeather(for: cityName) { result in
                DispatchQueue.main.async {
                    switch result {
                    case.success(let response):
                        self.update(with: response)
                    case.failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
}


extension HomeVC: UITextFieldDelegate, UIGestureRecognizerDelegate {
    func addGradientBackground(to view: UIView, colors: [UIColor], startPoint: CGPoint = CGPoint(x: 0.5, y: 0.0), endPoint: CGPoint = CGPoint(x: 0.5, y: 1.0)) {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.frame = view.bounds
        
        view.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        fetchdata()
        searchTextField.text = ""
        searchTextField.endEditing(true)
        return true
    }
    
    func addGradientBackground() {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [
            #colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 1).cgColor,
            #colorLiteral(red: 0.09301672131, green: 0.08545271307, blue: 0.2453529537, alpha: 0.896577381).cgColor,
        ]
        
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.frame = mainView.bounds
        
        mainView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func truncatedTemperature(_ temp: Double) -> Int {
        Int(temp)
    }
    
    func configureBackground() {
        configureWeatherView(detailsView, backgroundColor: .black, cornerRadius: 16)
        configureWeatherView(weatherView, backgroundColor: .black, cornerRadius: 16)
        configureWeatherView(forecastView, backgroundColor: .black, cornerRadius: 16)
        configureWeatherView(searchView, backgroundColor: .black, cornerRadius: 16)
        
        addGradientBackground()
        
        LocationManager.shared.fetchLocationDetails { country, state, city, error in
            if let error = error {
                print("Error fetching location details: \(error.localizedDescription)")
            } else {
                WeatherData.shared.currentCity = city ?? "default value"
                print("THIS IS DEFAULT CITY2: \(WeatherData.shared.currentCity)")
                print("Country: \(country ?? "Unknown")")
                print("State: \(state ?? "Unknown")")
                print("City: \(city ?? "Unknown")")
            }
        }
    }
    
    func update(with weather: WeatherResponse) {
        print("THIS ISSSSS\(weather.name)")
        tempretureLbl.text = "\(truncatedTemperature(weather.main.temp))°"
        lblHumidity.text = "\(weather.main.humidity)%"
        lblWindSpeed.text = "\(weather.wind.speed)"
        lblUVIndex.text = "\(weather.main.feels_like)"
        temratureDayLbl.text = "\(weather.weather.first?.main ?? "")"
        lblLocationName.text = weather.name
        
        if (weather.weather.first?.main == "Clear") {
            weatherAnimationView.isHidden = false
            imageLogo.isHidden = true
            createAnimation(on: self.weatherAnimationView, animationName: "Clear", loopMode: .loop)
        } else if (weather.weather.first?.main == "Clouds") {
            weatherAnimationView.isHidden = false
            imageLogo.isHidden = true
            createAnimation(on: self.weatherAnimationView, animationName: "Cloudy", loopMode: .loop)
        } else if (weather.weather.first?.main == "Rain") {
            weatherAnimationView.isHidden = false
            imageLogo.isHidden = true
            setupRainEffect()
            createAnimation(on: self.weatherAnimationView, animationName: "Raining", loopMode: .loop)
        } else {
            imageLogo.isHidden = false
            weatherAnimationView.isHidden = true
            imageLogo.image = UIImage(named: "weather")
        }
    }

    func setupRainEffect() {
        // Clear previous animations
        view.layer.sublayers?.filter { $0 is CAEmitterLayer }.forEach { $0.removeFromSuperlayer() }

        // Create a CAEmitterLayer
        let rainLayer = CAEmitterLayer()
        rainLayer.emitterPosition = CGPoint(x: view.bounds.width / 2, y: 0)
        rainLayer.emitterSize = CGSize(width: view.bounds.width, height: 1)
        rainLayer.emitterShape = .circle

        // Create raindrop cells
        let raindrop = CAEmitterCell()
        raindrop.contents = UIImage(named: "raindrop")?.cgImage
        raindrop.birthRate = 50
        raindrop.lifetime = 5
        raindrop.velocity = 300
        raindrop.velocityRange = 100
        raindrop.scale = 0.1
        raindrop.scaleRange = 0.05
        raindrop.yAcceleration = 300

        rainLayer.emitterCells = [raindrop]
        view.layer.addSublayer(rainLayer)
    }
    
    func HideKeyboardWhenTapAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
}
