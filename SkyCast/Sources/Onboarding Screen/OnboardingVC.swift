//
//  ViewController.swift
//  SkyCast
//
//  Created by Owais on 03/08/24.
//

import UIKit

class OnboardingVC: UIViewController {
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var appLogo: UIImageView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var descText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        btnStart.layer.cornerRadius = 12
        btnStart.addTarget(self, action: #selector(gotoHome), for: .touchUpInside)
    }
    
    @objc func gotoHome() {
        UserData.shared.isNewUser = true
        let vc = AppController.shared.home
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
