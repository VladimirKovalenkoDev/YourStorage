//
//  WhatInBoxViewController.swift
//  YourStorage
//
//  Created by Владимир Коваленко on 16.10.2020.
//  Copyright © 2020 Vladimir Kovalenko. All rights reserved.
//

import UIKit
import CoreData
class WhatInBoxViewController: UITableViewController {
    
   
    var selectedBox : Boxes? {
        didSet{
           loadData()
           
        }
    }
    let context  = C.context
    var things = [InBox]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 70
        
    }
    override func viewWillAppear(_ animated: Bool) {
        title = selectedBox!.name
        let fetchRequest = InBox.fetchRequest() as NSFetchRequest<InBox>
               do{
                   things = try context.fetch(fetchRequest)
               } catch let error{
                   print("THERE IS ERROR IN LOADING DATA \(error)")
               }
               tableView.reloadData()
      
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return things.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: C.whatInCell , for: indexPath) as! WhatInCell
        cell.thingsName.text = things[indexPath.row].things
        if things[indexPath.row].photo != nil {
            cell.thingsImge.image = UIImage(data: things[indexPath.row].photo!)
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
           return true
       }
    // MARK: - Deletion of birthday
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if things.count > indexPath.row{
            updateModel(at: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
   func saveData () {
            do {
               try  context.save()
            } catch {
            print("error saving context: \(error)/WhatInVC")
            }
           
            self.tableView.reloadData()
       }
       
        func loadData(with request:NSFetchRequest<InBox> = InBox.fetchRequest(), predicate: NSPredicate? = nil) {
              let boxPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedBox!.name!)
              if let additionalPredicate = predicate {
                  request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [boxPredicate,additionalPredicate])
              } else {
                  request.predicate = boxPredicate
              }
             
              do {
                 things =  try context.fetch(request)
              } catch  {
                  print("error fetching data from context:\(error)")
              }
              tableView.reloadData()
          }
        // MARK: -  Delete data from swipe
    func updateModel(at indexPath: IndexPath) {
       let thing = self.things[indexPath.row]
       self.context.delete(thing)
       self.things.remove(at: indexPath.row)
    print("deleted")
       }
   

}
