//
//  CalorieViewController.swift
//  HealthieApp
//
//  Created by Guillermo Hernandez on 3/17/20.
//  Copyright © 2020 Guillermo Hernandez. All rights reserved.
//

import UIKit

class CalorieViewController: UIViewController {
    
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is SignUpViewController2 {
            let stepTwoSignUp = segue.destination as! SignUpViewController2
            stepTwoSignUp.user = self.user
        }
    }

}
