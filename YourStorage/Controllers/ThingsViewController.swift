//
//  ThingsViewController.swift
//  YourStorage
//
//  Created by Владимир Коваленко on 18.10.2020.
//  Copyright © 2020 Vladimir Kovalenko. All rights reserved.
//

import UIKit
import CoreData

class ThingsViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var navbar: UINavigationBar!
    @IBOutlet weak var thingImage: UIImageView!
    @IBOutlet weak var thingNameTextField: UITextField!
    @IBOutlet weak var thingLabel: UILabel!
    let context = C.context
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
        let newThing = InBox(context: context)
        let imageData = thingImage.image?.pngData()//jpgData??
        let thing = thingNameTextField.text ?? "Thing1"
        newThing.things = thing
        newThing.photo = imageData
        DispatchQueue.main.async {
               do {
                     print("thing saved")
                try  self.context.save()
                 } catch {
                 print("error saving context: \(error)/ThingsVC")
                 }
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
