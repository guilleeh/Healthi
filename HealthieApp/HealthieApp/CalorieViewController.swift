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
    @IBOutlet var looseCalorieLabel: UILabel!
    @IBOutlet var maintainCalorieLabel: UILabel!
    @IBOutlet var gainCalorieLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let calories: Float = user?.calories ?? 1000.0
        self.looseCalorieLabel.text = String(calories - 300.0)
        self.maintainCalorieLabel.text = String(calories)
        self.gainCalorieLabel.text = String(calories + 300.0)
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
