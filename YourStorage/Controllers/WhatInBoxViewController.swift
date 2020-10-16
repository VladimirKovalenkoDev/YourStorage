//
//  WhatInBoxViewController.swift
//  YourStorage
//
//  Created by Владимир Коваленко on 16.10.2020.
//  Copyright © 2020 Vladimir Kovalenko. All rights reserved.
//

import UIKit

class WhatInBoxViewController: SwipeTableViewController {
    
    var selectedBox : Boxes? {
        didSet{
         //   loadData()
           
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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

//   func saveData () {
//            do {
//               try  context.save()
//            } catch {
//            print("error saving context: \(error)")
//            }
//           
//            self.tableView.reloadData()
//       }
//       
//       func loadData(with request:NSFetchRequest<Boxes> = Boxes.fetchRequest()) {
//           do {
//              boxes =  try context.fetch(request)
//           } catch  {
//               print("error fetching data from context:\(error)")
//               }
//           tableView.reloadData()
//       }
//        // MARK: -  Delete data from swipe
//   override func updateModel(at indexPath: IndexPath) {
//       
//       let box = self.boxes[indexPath.row]
//       self.context.delete(box)
//       self.boxes.remove(at: indexPath.row)
//       }
//   

}
