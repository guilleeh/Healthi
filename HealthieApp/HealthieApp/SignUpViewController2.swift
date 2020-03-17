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
