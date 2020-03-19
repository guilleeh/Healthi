//
//  Network.swift
//  HealthieApp
//
//  Created by Guillermo Hernandez on 3/18/20.
//  Copyright © 2020 Guillermo Hernandez. All rights reserved.
//

import UIKit

class Network: NSObject {

    
    func login(email: String, password:String) {

        let body: [String: Any] = ["email": email, "password": password]

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
                    print("We are logged in!")
                }
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}
