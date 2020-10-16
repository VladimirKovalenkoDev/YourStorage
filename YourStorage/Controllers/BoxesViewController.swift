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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addBox(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
               let alert = UIAlertController(title: "add new category", message: "", preferredStyle: .alert)
               let action = UIAlertAction(title: "Add Category", style: .default) { ( action) in
                   
               }
               alert.addTextField { (alertTextField) in
                   alertTextField.placeholder = "Crete new item"
                   
                   textField = alertTextField
               }
               alert.addAction(action)
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
    
}

