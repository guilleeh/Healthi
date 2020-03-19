//
//  LoginViewController.swift
//  HealthieApp
//
//  Created by Guillermo Hernandez on 2/18/20.
//  Copyright © 2020 Guillermo Hernandez. All rights reserved.
//


//                    guard let dataResponse = data,
//                           error == nil else {
//                           print(error?.localizedDescription ?? "Response Error")
//                           return }
//                     do{
//                         //here dataResponse received from a network request
//                         let jsonResponse = try JSONSerialization.jsonObject(with:
//                                                dataResponse, options: .allowFragments)
////                         print(jsonResponse) //Response result
//                        guard let jsonArray = jsonResponse as? [[String: Any]] else {
//                              return
//                        }
////
////                        guard let token = jsonArray[0]["token"] as? String else { return }
////                        print(token) //compiler outout -  delectus aut autem
////                        DispatchQueue.main.async {
////                            self.performSegue(withIdentifier: "loginSegue", sender: self)
////                        }
//                      } catch let parsingError {
//                         print("Error", parsingError)
//                    }

//                if let error = error {
//                    print("error: \(error)")
//                } else {
//                    if let response = response as? HTTPURLResponse {
//                        print(response)
//                        print("statusCode: \(response.statusCode)")
//
//                        if let data = data, let dataString = String(data: data, encoding: .utf8) {
//                            let defaults = UserDefaults.standard
//                            defaults.set("temp", forKey: "token")
//                            print()
//
//                        }
//                        if (response.statusCode == 200) {
//                            DispatchQueue.main.async {
//                                 self.performSegue(withIdentifier: "loginSegue", sender: self)
//                            }
//                        }
//                    }
//                }

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func onLogin(_ sender: Any) {
        if(emailField.text != "" && passwordField.text != "") {

            let body: [String: Any] = ["email": emailField.text, "password": passwordField.text]

            let url = URL(string: "http://localhost:8080/api/auth/login")!
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
                        defaults.set(json["token"], forKey: "token")
                        print(json["token"])
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "loginSegue", sender: self)
                        }
                    }
                } catch {
                    print("JSON error: \(error.localizedDescription)")
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
