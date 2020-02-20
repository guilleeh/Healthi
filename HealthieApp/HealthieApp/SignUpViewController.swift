//
//  SignUpViewController.swift
//  HealthieApp
//
//  Created by Guillermo Hernandez on 2/20/20.
//  Copyright © 2020 Guillermo Hernandez. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var fullNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var heightField: UITextField!
    @IBOutlet weak var weightField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onRegister(_ sender: Any) {
        if(fullNameField.text != "" && emailField.text != "" && passwordField.text != "" && confirmPasswordField.text != "" && ageField.text != "" && heightField.text != "" && weightField.text != "") {
            let body: [String: Any] = [    "name": fullNameField.text!,
                                           "email": emailField.text!,
                                           "password": passwordField.text!,
                                           "age": ageField.text!,
                                           "height": heightField.text!,
                                           "weight": weightField.text!]
            
            let url = URL(string: "http://localhost:5000/api/auth/signup")!
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
                        if let data = data, let dataString = String(data: data, encoding: .utf8) {
                            print("data: \(dataString)")
                        }
                        if (response.statusCode == 200) {
                            DispatchQueue.main.async {
                                 self.performSegue(withIdentifier: "signUpSegue", sender: self)
                            }
                        }
                    }
                }
            }
            task.resume()
        }
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
