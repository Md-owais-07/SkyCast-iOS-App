//
//  UIVC+Extension.swift
//  SkyCast
//
//  Created by Owais on 12/12/24.
//

import UIKit
import Lottie

extension UIViewController {
    func createAnimation(on view: UIView, animationName: String, loopMode: LottieLoopMode = .playOnce) {
        let animationView = LottieAnimationView(name: animationName)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        animationView.frame = view.bounds
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)

        // Center the animationView inside the passed view using Auto Layout
        NSLayoutConstraint.activate([
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])

        animationView.play()
    }
    
    func configureWeatherView(_ view: UIView, backgroundColor: UIColor, cornerRadius: CGFloat, alpha: CGFloat = 0.1) {
        view.backgroundColor = backgroundColor.withAlphaComponent(alpha)
        view.layer.cornerRadius = cornerRadius
    }

}
