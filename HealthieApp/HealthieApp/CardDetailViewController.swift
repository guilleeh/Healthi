//
//  CardDetailViewController.swift
//  HealthieApp
//
//  Created by Guillermo Hernandez on 3/18/20.
//  Copyright © 2020 Guillermo Hernandez. All rights reserved.
//

import UIKit
import Alamofire

class CardDetailViewController: UIViewController {
    
    var food: Food?
    @IBOutlet var foodImage: UIImageView!
    @IBOutlet var foodLabel: UILabel!
    @IBOutlet var caloriesLabel: UILabel!
    @IBOutlet var recipeLabel: UILabel!
    @IBOutlet var healthLabel: UILabel!
    @IBOutlet var stepsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(food?.label)
        
        guard let url = URL(string: food?.image ?? "") else { return }

        UIImage.loadFrom(url: url) { image in
            self.foodImage.image = image
        }
        
        
        foodLabel.text = food?.label
        caloriesLabel.text = food?.calories?.stringValue
        recipeLabel.text = food?.url
        let arr = self.food?.dietLabels ?? []
        var str = ""
        for each in arr {
            str += (each ?? "") + ", " ?? ""
        }
        
        for each in self.food?.healthLabels ?? [] {
            str += (each ?? "") + ", " ?? ""
        }
        
        for each in self.food?.cautions ?? [] {
            str += (each ?? "") + ", " ?? ""
        }
        
        self.healthLabel.text = str
        // Do any additional setup after loading the view.
    }


}

extension UIImage {

    public static func loadFrom(url: URL, completion: @escaping (_ image: UIImage?) -> ()) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    completion(UIImage(data: data))
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }

}
