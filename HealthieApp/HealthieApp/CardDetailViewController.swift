//
//  CardDetailViewController.swift
//  HealthieApp
//
//  Created by Guillermo Hernandez on 3/18/20.
//  Copyright © 2020 Guillermo Hernandez. All rights reserved.
//

import UIKit

class CardDetailViewController: UIViewController {
    
    var food: Food?
    @IBOutlet var foodImage: UIImageView!
    @IBOutlet var foodLabel: UILabel!
    @IBOutlet var caloriesLabel: UILabel!
    @IBOutlet var recipeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(food?.label)
        
        foodLabel.text = food?.label
        caloriesLabel.text = food?.calories?.stringValue
        recipeLabel.text = food?.url
        
        

        // Do any additional setup after loading the view.
    }
    
    
    

}
