//
//  SignUpViewController.swift
//  HealthieApp
//
//  Created by Guillermo Hernandez on 2/20/20.
//  Copyright © 2020 Guillermo Hernandez. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var fullNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var heightPicker: UIPickerView!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet var gender: UISegmentedControl!
    @IBOutlet var goal: UISegmentedControl!
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var lifestylePicker: UIPickerView!
    
    var pickerHeightData: [String] = [String]()
    var lifestyleData: [String] = [String]()
    var selectedHeight:String = ""
    var selectedLifestyle:String = ""
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //init user
        self.user = User()
        
        // Connect data:
        self.heightPicker.delegate = self
        self.heightPicker.dataSource = self
        
        self.lifestylePicker.delegate = self
        self.lifestylePicker.dataSource = self
        
        pickerHeightData = ["4.0", "4.1", "4.2", "4.3", "4.4", "4.5", "4.6", "4.7", "4.8", "4.9", "4.1", "4.11", "5.0", "5.1", "5.2", "5.3", "5.4", "5.5", "5.6", "5.7", "5.8", "5.9", "5.1", "5.11", "6.0"]
        
        lifestyleData = ["Lightly Active", "Moderately Active", "Very Active"]
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView == heightPicker) {
            return pickerHeightData.count
        } else {
            return lifestyleData.count
        }
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String {

        if (pickerView == heightPicker) {
            self.selectedHeight = pickerHeightData[row]
            return pickerHeightData[row]
        } else {
            self.selectedLifestyle = lifestyleData[row]
            return lifestyleData[row]
        }
    }
    
    func createUser() {
        self.user?.name = self.fullNameField.text!
        self.user?.age = self.ageField.text!
        self.user?.email = self.emailField.text!
        self.user?.password = self.passwordField.text!
        self.user?.weight = self.weightField.text!
        self.user?.lifestyle = selectedLifestyle
        self.user?.height = selectedHeight
        self.user?.gender = self.gender.titleForSegment(at: gender.selectedSegmentIndex)
        self.user?.goal = [self.goal.titleForSegment(at: gender.selectedSegmentIndex)]
        self.user?.calculateCalories()
        do {
            sleep(1
            )
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        createUser()
        if segue.destination is CalorieViewController {
            let calorie = segue.destination as! CalorieViewController
            calorie.user = self.user
        }
    }

}
