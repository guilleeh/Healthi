//
//  SignUpViewController4.swift
//  HealthieApp
//
//  Created by Guillermo Hernandez on 3/14/20.
//  Copyright © 2020 Guillermo Hernandez. All rights reserved.
//

import UIKit

class SignUpViewController4: UIViewController, UITableViewDataSource, UITableViewDelegate {
        
    @IBOutlet var greetingLabel: UILabel!
    @IBOutlet var optionsTableView: UITableView!
    
    var options: [String] = [String]()
    var user: User?
    var network = Network()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("Here!")
        optionsTableView.dataSource = self
        optionsTableView.delegate = self
        
        optionsTableView.allowsMultipleSelectionDuringEditing = true
        optionsTableView.setEditing(true, animated: false)
        
        options = ["Eggs",
                   "FODMAP",
        "Gluten",
        "Milk",
        "Peanuts",
        "Shellfish",
        "Soy",
        "Sulfites",
        "Tree-Nuts",
        "Wheat"]
        
        greetingLabel.text = "Caution Options"
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func submit(_ sender: Any) {
        user?.repr()
        let values = optionsTableView.indexPathsForSelectedRows ?? []
        var selections:[String] = [String]()
        for val in values {
            let selection = String(options[val[1]])
            selections.append(selection)
        }
        user?.cautionLabels = selections
                let body: [String: Any] = [    "name": self.user?.name! ?? "",
                                               "email": self.user?.email! ?? "",
                                               "password": self.user?.password! ?? "",  
                                               "age": Int(self.user!.age!) ?? 14,
                                               "height": Int((self.user!.height as! NSString).doubleValue * 30.48),
                                               "weight": Int((self.user!.weight!)) ?? 50,
                                               "dietLabels": self.user?.dietLabels,
                                               "healthLabels": self.user?.healthLabels,
                                               "cautions": self.user?.cautionLabels,
                                               "objective": self.user?.goal
        ]
                                                
                print(body)
        
                    let url = URL(string: "http://localhost:8080/api/auth/signup")!
                    var request = URLRequest(url: url)
                    // prepare json data
                    let json: [String: Any] = body

                    let jsonData = try? JSONSerialization.data(withJSONObject: json)
                    request.httpMethod = "POST"
                    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                    request.addValue("application/json", forHTTPHeaderField: "Accept")
                    request.httpBody = jsonData
        
                    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                        if error != nil || data == nil {
                            print("Client error!")
                            return
                        }

                        guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                            print("Server error!")
                            return
                        }

                        guard let mime = response.mimeType, mime == "application/json" else {
                            print("Wrong MIME type!")
                            return
                        }

                        do {
                            if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                                let defaults = UserDefaults.standard
                                defaults.set(json["id"], forKey: "token")
                                print(json["id"])
                                DispatchQueue.main.async {
                                    self.performSegue(withIdentifier: "registerSegue", sender: self)
                                }
                            }
                        } catch {
                            print("JSON error: \(error.localizedDescription)")
                        }
                    }
                    task.resume()
//
//                    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//                        if let error = error {
//                            print("error: \(error)")
//                        } else {
//                            if let response = response as? HTTPURLResponse {
//                                print("statusCode: \(response.statusCode)")
//                                if let data = data, let dataString = String(data: data, encoding: .utf8) {
//                                    print("data: \(dataString)")
//                                }
//                                if (response.statusCode == 200) {
//                                    DispatchQueue.main.async {
//                                         self.performSegue(withIdentifier: "registerSegue", sender: nil)
//                                    }
//                                }
//                            }
//                        }
//                    }
//                    task.resume()
//        network.login(email: self.user?.email ?? "", password: self.user?.password ?? "")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel!.text = "\(options[indexPath.row])"
        
        return cell
    }

}
