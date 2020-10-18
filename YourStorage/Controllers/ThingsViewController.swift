//
//  ThingsViewController.swift
//  YourStorage
//
//  Created by Владимир Коваленко on 18.10.2020.
//  Copyright © 2020 Vladimir Kovalenko. All rights reserved.
//

import UIKit
import CoreData

class ThingsViewController: UIViewController {
//var palceString = ""
    
   // @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var thingNameTextField: UITextField!
    @IBOutlet weak var thingLabel: UILabel!
    let context = C.context
    override func viewDidLoad() {
        super.viewDidLoad()
        thingNameTextField.delegate = self
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton ) {
        let newThing = InBox(context: context)
        let thing = thingNameTextField.text ?? "Thing1"
        newThing.things = thing
        do {
            print("thing saved")
           try  context.save()
        } catch {
        print("error saving context: \(error)/ThingsVC")
        }
        dismiss(animated: true, completion: nil)
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
