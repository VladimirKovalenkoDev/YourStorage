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
    let context  = C.context
    var things = [InBox]()
    override func viewDidLoad() {
        super.viewDidLoad()
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
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.text = things[indexPath.row].things
        if things[indexPath.row].photo != nil {
        cell.imageView?.image = UIImage(data: things[indexPath.row].photo!)
        }
        return cell
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
   override func updateModel(at indexPath: IndexPath) {
       
       let thing = self.things[indexPath.row]
       self.context.delete(thing)
       self.things.remove(at: indexPath.row)
    print("deleted")
       }
   

}
