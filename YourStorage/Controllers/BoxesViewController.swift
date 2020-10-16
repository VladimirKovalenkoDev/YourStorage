//
//  ViewController.swift
//  YourStorage
//
//  Created by Владимир Коваленко on 16.10.2020.
//  Copyright © 2020 Vladimir Kovalenko. All rights reserved.
//

import UIKit
import CoreData

class BoxesViewController: SwipeTableViewController {
    
    var boxes = [Boxes]()
    var textField = UITextField()
    let context  = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
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
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        let box = boxes[indexPath.row]
        cell.textLabel?.text = box.name
           return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == C.boxToWhatIsSegue {
            let destinationVC = segue.destination as! WhatInBoxViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.selectedBox = boxes[indexPath.row]
            }
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
                print("error fetching data from context:\(error)")
                }
            tableView.reloadData()
        }
         // MARK: -  Delete data from swipe
    override func updateModel(at indexPath: IndexPath) {
        
        let box = self.boxes[indexPath.row]
        self.context.delete(box)
        self.boxes.remove(at: indexPath.row)
        }
    
}


