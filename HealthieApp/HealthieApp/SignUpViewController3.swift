//
//  SignUpViewController3.swift
//  HealthieApp
//
//  Created by Guillermo Hernandez on 3/14/20.
//  Copyright © 2020 Guillermo Hernandez. All rights reserved.
//

import UIKit

class SignUpViewController3: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var options: [String] = [String]()
    var user: User?
    @IBOutlet var greetingLabel: UILabel!
    @IBOutlet var optionsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("Here!")
        user?.repr()
        optionsTableView.dataSource = self
        optionsTableView.delegate = self
        
        optionsTableView.allowsMultipleSelectionDuringEditing = true
        optionsTableView.setEditing(true, animated: false)
        
        options = ["Alcohol-Cocktail",
                   "Alcohol-Free",
                   "Peanut-Free",
                   "Sugar-Conscious",
                   "Tree-Nut-Free",
                   "Vegan",
                   "Vegetarian"]
        
        greetingLabel.text = "Health Options"

        // Do any additional setup after loading the view.
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let values = optionsTableView.indexPathsForSelectedRows ?? []
        var selections:[String] = [String]()
        for val in values {
            let selection = String(options[val[1]])
            selections.append(selection)
        }
        user?.healthLabels = selections
        
        if segue.destination is SignUpViewController4 {
            let stepFourSignUp = segue.destination as! SignUpViewController4
            stepFourSignUp.user = self.user
        }
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
