//
//  User.swift
//  HealthieApp
//
//  Created by Guillermo Hernandez on 3/12/20.
//  Copyright © 2020 Guillermo Hernandez. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: String?
    var email: String?
    var password: String?
    var age: String?
    var weight: String?
    var lifestyle: String?
    var height: String?
    var dietLabels: [String?] = []
    var healthLabels: [String?] = []
    var cautionLabels: [String?] = []
    
    func repr() {        // type method
//        print(self.name!)
//        print(self.email!)
//        print(self.password!)
//        print(self.age!)
//        print(self.weight!)
//        print(self.lifestyle!)
//        print(self.height!)
        print(self.dietLabels)
        print(self.healthLabels)
        print(self.cautionLabels)
    }
}
