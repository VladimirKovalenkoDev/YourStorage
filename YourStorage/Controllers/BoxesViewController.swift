//
//  ViewController.swift
//  YourStorage
//
//  Created by Владимир Коваленко on 16.10.2020.
//  Copyright © 2020 Vladimir Kovalenko. All rights reserved.
//

import UIKit
import CoreData

class BoxesViewController: UITableViewController {
    
    var boxes = [Boxes]()
    var textField = UITextField()
    let context  = C.context
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    @IBAction func addBox(_ sender: UIBarButtonItem) {
               let alert = UIAlertController(title: "add new box", message: "", preferredStyle: .alert)
               let action = UIAlertAction(title: "Add Category", style: .default) { ( action) in
                let newBox = Boxes(context: self.context)
                newBox.name = self.textField.text!
                self.boxes.append(newBox)
                self.saveData()
               }
               let cancel = UIAlertAction(title: "Cancel", style: .cancel)
               alert.addTextField { (field) in
                   field.placeholder = "Add box"
                   self.textField = field
               }
               alert.addAction(action)
               alert.addAction(cancel)
               present(alert, animated: true, completion: nil)
    }
    // MARK: - TableView Manipulations
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boxes.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: C.cells , for: indexPath)
        let box = boxes[indexPath.row]
        cell.textLabel?.text = box.name
           return cell
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
           return true
       }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if boxes.count > indexPath.row{
            updateModel(at: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
            let destinationVC = segue.destination as! WhatInBoxViewController
        
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.selectedBox = boxes[indexPath.row].name!
            }
        
    }
   // MARK: - Coredata Manipulations
    func saveData () {
             do {
                try  context.save()
             } catch {
             print("error saving context: \(error)")
             }
            
             self.tableView.reloadData()
        }
        
        func loadData(with request:NSFetchRequest<Boxes> = Boxes.fetchRequest()) {
            do {
               boxes =  try context.fetch(request)
            } catch  {
                print("error fetching data from context:\(error)/BoxesVC")
                }
            tableView.reloadData()
        }
         // MARK: -  Delete data from swipe
      func updateModel(at indexPath: IndexPath) {
        
        let box = self.boxes[indexPath.row]
        self.context.delete(box)
        self.boxes.remove(at: indexPath.row)
        }
    
}


