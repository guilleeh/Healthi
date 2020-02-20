//
//  LoginViewController.swift
//  HealthieApp
//
//  Created by Guillermo Hernandez on 2/18/20.
//  Copyright © 2020 Guillermo Hernandez. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func onLogin(_ sender: Any) {
        if(emailField.text != "" && passwordField.text != "") {
            
            let body: [String: Any] = ["email": emailField.text, "password": passwordField.text]
            
            let url = URL(string: "http://localhost:5000/api/auth/login")!
            var request = URLRequest(url: url)
            // prepare json data
            let json: [String: Any] = body

            let jsonData = try? JSONSerialization.data(withJSONObject: json)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("error: \(error)")
                } else {
                    if let response = response as? HTTPURLResponse {
                        print("statusCode: \(response.statusCode)")
                        print("data: \(response)")
                        DispatchQueue.main.async {
                             self.performSegue(withIdentifier: "loginSegue", sender: self)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
