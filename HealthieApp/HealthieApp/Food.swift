//
//  Food.swift
//  HealthieApp
//
//  Created by Guillermo Hernandez on 3/18/20.
//  Copyright © 2020 Guillermo Hernandez. All rights reserved.
//

import UIKit

class Food: NSObject {
    var image: String?
    var label: String?
    var calories: NSNumber?
    var url: String?
    var dietLabels: [String?] = []
    var healthLabels: [String?] = []
    var cautions: [String?] = []
}
