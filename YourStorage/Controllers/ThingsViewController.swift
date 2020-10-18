//
//  ThingsViewController.swift
//  YourStorage
//
//  Created by Владимир Коваленко on 18.10.2020.
//  Copyright © 2020 Vladimir Kovalenko. All rights reserved.
//

import UIKit

class ThingsViewController: UIViewController {
//var palceString = ""
    
    @IBOutlet weak var thingNameTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var thingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        thingNameTextField.delegate = self
    }
    


}
// MARK: - TextField Delegate Methods
extension ThingsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       thingNameTextField.endEditing(true)
        thingLabel.text = thingNameTextField.text

        return true
    }
}
