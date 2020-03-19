//
//  MainViewController.swift
//  HealthieApp
//
//  Created by Guillermo Hernandez on 3/12/20.
//  Copyright © 2020 Guillermo Hernandez. All rights reserved.
//

import UIKit
import Koloda
import AlamofireImage

class MainViewController: UIViewController, UISearchBarDelegate{
    @IBOutlet var searchBar: UISearchBar!
    
    @IBOutlet var kolodaView: KolodaView!
    var images: [Food] = []
    
    @IBAction func settings(_ sender: UIButton) {
        self.performSegue(withIdentifier: "settingsSegue", sender: nil)
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("I was clicked!")
        if( searchBar.text != "") {
            let url = URL(string: "http://localhost:8080/api/auth/search/" + (searchBar.text ?? ""))!

            let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                guard let data = data else { return }
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                        var results: [Food] = []
                        for each in json {
                            var food: Food = Food()
                            food.image = each["image"] as! String
                            food.label = each["label"] as! String
                            food.calories = each["calories"] as? NSNumber
                            results.append(food)
                        }
                        self.images = results
                        
                        DispatchQueue.main.async {
                            self.kolodaView.reloadData()
                        }
                    }
                    print(self.images)
                } catch let err {
                    print(err)
                }
            }

            task.resume()
            }
        searchBar.text = ""
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the Navigation Bar
        self.searchBar.delegate=self 
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Show the Navigation Bar
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kolodaView.layer.cornerRadius = 20
        kolodaView.clipsToBounds = true
        
        kolodaView.dataSource = self
        kolodaView.delegate = self
        
        let defaults = UserDefaults.standard
        let name = defaults.string(forKey: "token")
    }
}


extension MainViewController: KolodaViewDelegate {
  func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
    koloda.reloadData()
  }
  
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
        if direction == SwipeResultDirection.right {
             // implement your functions or whatever here
            print("user swiped right")
        } else if direction == .left {
        // implement your functions or whatever here
            print("user swiped left")
        }
  }
}


extension MainViewController: KolodaViewDataSource {
  
  func kolodaNumberOfCards(_ koloda:KolodaView) -> Int {
    return images.count
  }
  
  func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
    let imageUrl = URL(string: (images[index].image as? String)!)
        let data = try? Data(contentsOf: imageUrl!)
        
        if let imageData = data {
            
            let view = UIImageView(image: UIImage(data: imageData))
            view.layer.cornerRadius = 20
            view.clipsToBounds = true
            return view
        } else {
            let view = UIImageView(image: UIImage(named: images[index].label ?? ""))
            view.layer.cornerRadius = 20
            view.clipsToBounds = true
            return view
        }
    }
    
}

