//
//  User.swift
//  HealthieApp
//
//  Created by Guillermo Hernandez on 3/12/20.
//  Copyright © 2020 Guillermo Hernandez. All rights reserved.
//

//For men:
//BMR = 10W + 6.25H - 5A + 5
//For women:
//BMR = 10W + 6.25H - 5A - 161

import UIKit

class User: NSObject {
    var name: String?
    var email: String?
    var password: String?
    var age: String?
    var weight: String?
    var gender: String?
    var lifestyle: String?
    var height: String?
    var dietLabels: [String?] = []
    var healthLabels: [String?] = []
    var cautionLabels: [String?] = []
    var calories: Float?
    var token: String?
    
    func repr() {        // type method
//        print(self.name!)
//        print(self.email!)
//        print(self.password!)
//        print(self.age!)
//        print(self.weight!)
//        print(self.lifestyle!)
//        print(self.height!)
        print(gender)
        print(self.dietLabels)
        print(self.healthLabels)
        print(self.cautionLabels)
    }
    
    func calculateCalories() {
        /*
         Calculates calorie intake for user
         */
    
        let w = 10.0 * (Float(weight ?? "") ?? 60)
        let h = 6.25 * ((Float(height ?? "") ?? 10) * 30.48)
        let a = 5.0 * (Float(age ?? "") ?? 15)
        var result:Float = 0
        if(gender == "Male") {
            result = w + h + a + 5.0
        }
        result = w + h + a - 161.0
        
        if (self.lifestyle == "Lightly Active") {
            calories = Float(result) * 1.375
        } else if (self.lifestyle == "Moderately Active") {
            calories = Float(result) * 1.55
        } else {
            calories = Float(result) * 1.725
        }
        print(self.calories)
    }
}
