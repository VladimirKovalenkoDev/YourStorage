//
//  ViewController.swift
//  YourStorage
//
//  Created by Владимир Коваленко on 16.10.2020.
//  Copyright © 2020 Vladimir Kovalenko. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class BoxesViewController: UITableViewController {
    
    
    var boxes : Results<Boxes>?
    var textField = UITextField()
    var realmService = RealmService ()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    @IBAction func addBox(_ sender: UIBarButtonItem) {
               let alert = UIAlertController(title: "add new box", message: "", preferredStyle: .alert)
               let action = UIAlertAction(title: "Add Category", style: .default) { ( action) in
                let newBox = Boxes()
                newBox.name = self.textField.text!
                self.saveData(box: newBox)
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
        return boxes?.count ?? 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: C.cells , for: indexPath)
        let box = boxes?[indexPath.row]
        cell.textLabel?.text = box?.name
           return cell
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
           return true
       }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if boxes?.count ?? 0 > indexPath.row{
            updateModel(at: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
            let destinationVC = segue.destination as! WhatInBoxViewController
        
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.selectedBox = boxes?[indexPath.row].name ?? "NAME"
            }
        
    }
   // MARK: - DATA Manipulations
    func saveData (box: Boxes) {
        self.realmService.saveData(object: box)
        tableView.reloadData()
        }
        
        func loadData() {
            let results = self.realmService.loadData(type: Boxes.self)
            boxes = results
                   tableView.reloadData()
        }
      func updateModel(at indexPath: IndexPath) {
        if let thing = self.boxes?[indexPath.row] {
            self.realmService.deleteData(object: thing)
        }
        }
    
}


