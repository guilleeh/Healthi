//
//  SettingsViewController.swift
//  HealthieApp
//
//  Created by Guillermo Hernandez on 3/17/20.
//  Copyright © 2020 Guillermo Hernandez. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logout(_ sender: Any) {
        self.performSegue(withIdentifier: "logoutSegue", sender: nil)
    }
    
}
