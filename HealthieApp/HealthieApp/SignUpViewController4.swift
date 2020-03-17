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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("Here!")
        optionsTableView.dataSource = self
        optionsTableView.delegate = self
        
        optionsTableView.allowsMultipleSelectionDuringEditing = true
        optionsTableView.setEditing(true, animated: false)
        
        options = ["FODMAP", "Gluten", "Shellfish", "Sulfites", "Wheat"]
        
        greetingLabel.text = "Caution Options"
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func submit(_ sender: Any) {
        user?.repr()
        self.performSegue(withIdentifier: "registerSegue", sender: nil)
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
