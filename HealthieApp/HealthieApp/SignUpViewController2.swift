//
//  SignUpViewController2.swift
//  HealthieApp
//
//  Created by Guillermo Hernandez on 3/12/20.
//  Copyright © 2020 Guillermo Hernandez. All rights reserved.
//

import UIKit

class SignUpViewController2: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var optionsTableView: UITableView!
    
    var options: [String] = [String]()
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Here!")
        optionsTableView.dataSource = self
        optionsTableView.delegate = self
        
        optionsTableView.allowsMultipleSelectionDuringEditing = true
        optionsTableView.setEditing(true, animated: false)
        
        options = ["Low-Carb", "Low-Fat"]

        
        // Do any additional setup after loading the view.
        greetingLabel.text = "Diet Options"
    }
    
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel!.text = "\(options[indexPath.row])"
        
        return cell
    }
    
    
    @IBAction func onRegister(_ sender: Any) {
//        let body: [String: Any] = [    "name": self.user?.name! ?? "",
//                                       "email": self.user?.email! ?? "",
//                                       "password": self.user?.password! ?? "",
//                                       "age": Int(self.user!.age!) ?? 14,
//                                       "height": Int((self.user!.height as! NSString).doubleValue * 30.48),
//                                       "weight": Int((self.user!.weight!)) ?? 50]
//        print(body)
//
//            let url = URL(string: "http://localhost:8080/api/auth/signup")!
//            var request = URLRequest(url: url)
//            // prepare json data
//            let json: [String: Any] = body
//
//            let jsonData = try? JSONSerialization.data(withJSONObject: json)
//            request.httpMethod = "POST"
//            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//            request.addValue("application/json", forHTTPHeaderField: "Accept")
//            request.httpBody = jsonData
//
//            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//                if let error = error {
//                    print("error: \(error)")
//                } else {
//                    if let response = response as? HTTPURLResponse {
//                        print("statusCode: \(response.statusCode)")
//                        if let data = data, let dataString = String(data: data, encoding: .utf8) {
//                            print("data: \(dataString)")
//                        }
//                        if (response.statusCode == 200) {
//                            DispatchQueue.main.async {
//                                 self.performSegue(withIdentifier: "doneRegisterSegue", sender: self)
//                            }
//                        }
//                    }
//                }
//            }
//            task.resume()
        let values = optionsTableView.indexPathsForSelectedRows!
        var selections:[String] = [String]()
        for val in values {
            let selection = String(options[val[1]])
            selections.append(selection)
        }
        user?.dietLabels = selections   
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let values = optionsTableView.indexPathsForSelectedRows ?? []
        var selections:[String] = [String]()
        for val in values {
            let selection = String(options[val[1]])
            selections.append(selection)
        }
        user?.dietLabels = selections
        
        if segue.destination is SignUpViewController3 {
            let stepThreeSignUp = segue.destination as! SignUpViewController3
            stepThreeSignUp.user = self.user
        }
    }
    
}
