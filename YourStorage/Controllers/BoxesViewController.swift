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
    }

    @IBAction func addBox(_ sender: UIBarButtonItem) {
               let alert = UIAlertController(title: "add new box", message: "", preferredStyle: .alert)
               let action = UIAlertAction(title: "Add Category", style: .default) { ( action) in
                   
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
           return cell
    }
    
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


