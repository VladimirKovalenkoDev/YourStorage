//
//  ThingsViewController.swift
//  YourStorage
//
//  Created by Владимир Коваленко on 18.10.2020.
//  Copyright © 2020 Vladimir Kovalenko. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class ThingsViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var navbar: UINavigationBar!
    @IBOutlet weak var thingImage: UIImageView!
    @IBOutlet weak var thingNameTextField: UITextField!
    @IBOutlet weak var thingLabel: UILabel!
    var realmService = RealmService ()
    override func viewDidLoad() {
        super.viewDidLoad()
        thingNameTextField.delegate = self
    }
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func cameraAccess(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let cameraView = UIImagePickerController()
            cameraView.delegate = self
            cameraView.sourceType = .camera
            self.present(cameraView, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.originalImage.rawValue)] as? UIImage{
            thingImage.contentMode = .scaleAspectFit
            thingImage.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton ) {
        let newThing = InBox()
       //jpgData??
        let thing = thingNameTextField.text ?? "Thing1"
        newThing.things = thing
        newThing.photo = thingImage.image?.pngData()
         self.realmService.saveData(object: newThing)
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
     
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
