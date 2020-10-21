//
//  WhatInBoxViewController.swift
//  YourStorage
//
//  Created by Владимир Коваленко on 16.10.2020.
//  Copyright © 2020 Vladimir Kovalenko. All rights reserved.
//

import UIKit
import RealmSwift
class WhatInBoxViewController: UITableViewController {
    
    var selectedBox: Boxes? {
        didSet {
            loadItems()
        }
    }
    var things : Results<InBox>?
    var realmService = RealmService()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 70
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadItems()
        title = selectedBox!.name
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return things?.count ?? 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: C.whatInCell , for: indexPath) as! WhatInCell
        DispatchQueue.main.async {
            if self.things?[indexPath.row].photo != nil {
                cell.thingsImge.image = UIImage(data: (self.things?[indexPath.row].photo!)!)
            }
        }
        cell.thingsName.text = things?[indexPath.row].things
        
        return cell
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
           return true
       }
    // MARK: - Deletion of birthday
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if things?.count ?? 0 > indexPath.row{
            updateModel(at: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    // MARK: - DATA Manipulation
//   func saveData () {
//
//            self.tableView.reloadData()
//       }
       func loadData() {
        let results = self.realmService.loadData(type: InBox.self)
        things = results
               tableView.reloadData()
           }
   func  loadItems(){
    things = selectedBox?.inBox.sorted(byKeyPath: "things", ascending: true)
        tableView.reloadData()
    }

    func updateModel(at indexPath: IndexPath) {
        if let thing = self.things?[indexPath.row] {
            self.realmService.deleteData(object: thing)
        }
    print("deleted")
       }
   

}
