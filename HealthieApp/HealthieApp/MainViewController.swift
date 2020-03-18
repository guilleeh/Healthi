//
//  MainViewController.swift
//  HealthieApp
//
//  Created by Guillermo Hernandez on 3/12/20.
//  Copyright © 2020 Guillermo Hernandez. All rights reserved.
//

import UIKit
import Koloda

class MainViewController: UIViewController{
    
    @IBOutlet var kolodaView: KolodaView!
    let images = ["burger", "coffee", "pizza", "salmon", "steak"]
    
    @IBAction func settings(_ sender: UIButton) {
        self.performSegue(withIdentifier: "settingsSegue", sender: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the Navigation Bar
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
//    let alert = UIAlertController(title: "Congratulation!", message: "Now you're \(images[index])", preferredStyle: .alert)
//    alert.addAction(UIAlertAction(title: "OK", style: .default))
//    self.present(alert, animated: true)
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
    let view = UIImageView(image: UIImage(named: images[index]))
    view.layer.cornerRadius = 20
    view.clipsToBounds = true
    return view
    }
}

