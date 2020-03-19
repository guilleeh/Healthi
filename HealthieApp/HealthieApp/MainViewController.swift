//
//  MainViewController.swift
//  HealthieApp
//
//  Created by Guillermo Hernandez on 3/12/20.
//  Copyright © 2020 Guillermo Hernandez. All rights reserved.
//

import UIKit
import Koloda

class MainViewController: UIViewController, UISearchBarDelegate{
    @IBOutlet var searchBar: UISearchBar!
    
    @IBOutlet var kolodaView: KolodaView!
    var images = [String]()
    
    @IBAction func settings(_ sender: UIButton) {
        self.performSegue(withIdentifier: "settingsSegue", sender: nil)
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("I was clicked!")
        if( searchBar.text != "") {
//            let url = URL(string: "http://localhost:8080/api/auth/search/cookie")!
//            print(url)
//            var request = URLRequest(url: url)
//
//            request.httpMethod = "GET"
//            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//            request.addValue("application/json", forHTTPHeaderField: "Accept")
//
//
//            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//                    if error != nil || data == nil {
//                        print("Client error!")
//                        return
//                    }
//
//                    guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
//                        print("Server error!")
//                        return
//                    }
//
//                    guard let mime = response.mimeType, mime == "application/json" else {
//                        print("Wrong MIME type!")
//                        return
//                    }
//
//                    do {
//                        if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
//                            print(json)
//                            }
//                    } catch {
//                        print("JSON error: \(error.localizedDescription)")
//                    }
//                }
//                task.resume()
            let url = URL(string: "http://localhost:8080/api/auth/search/" + (searchBar.text ?? ""))!

            let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                guard let data = data else { return }
                
                do {
//                    let jsonResult =  try JSONSerialization.jsonObject(with: data, options: [])
//                    print(type(of: jsonResult))
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                        for each in json {
                            self.images.append(each["image"] as! String)
                            
                        }
                    }
                    print(self.images)
                    
                } catch let err {
                    print(err)
                }
//                print(String(data: data, encoding: .utf8)!)
                
                
                
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
//    let view = UIImageView(image: UIImage(named: images[index]))
    
    let view = UIImageView()
    
    let imageUrlString = images[index]
    print(imageUrlString)
    
    guard let imageUrl:URL = URL(string: imageUrlString) else {
        return UIView()
    }
    view.load(url: imageUrl)
    
    view.layer.cornerRadius = 20
    view.clipsToBounds = true
    return view
    }
    
}


extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
