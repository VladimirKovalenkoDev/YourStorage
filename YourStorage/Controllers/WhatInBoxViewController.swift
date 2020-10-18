//
//  WhatInBoxViewController.swift
//  YourStorage
//
//  Created by Владимир Коваленко on 16.10.2020.
//  Copyright © 2020 Vladimir Kovalenko. All rights reserved.
//

import UIKit
import CoreData
class WhatInBoxViewController: SwipeTableViewController {
    
    var selectedBox : Boxes? {
        didSet{
           loadData()
           
        }
    }
    let context  = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var things = [InBox]()
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        title = selectedBox!.name
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
   func saveData () {
            do {
               try  context.save()
            } catch {
            print("error saving context: \(error)")
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
   override func updateModel(at indexPath: IndexPath) {
       
       let thing = self.things[indexPath.row]
       self.context.delete(thing)
       self.things.remove(at: indexPath.row)
       }
   

}
