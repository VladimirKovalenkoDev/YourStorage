//
//  RealmService.swift
//  YourStorage
//
//  Created by Владимир Коваленко on 21.10.2020.
//  Copyright © 2020 Vladimir Kovalenko. All rights reserved.
//

import Foundation
import RealmSwift
public class DBCollection<T: RealmCollectionValue> {

    public var count: Int { return results.count }

    let results: Results<T>

    init(_ results: Results<T>) {
        self.results = results
    }

    public subscript(index: Int) -> T {
        return results[index]
    }
}


public final class RealmService {
    public func saveData<T:Object>(object: T){
        if let realm = try? Realm() {
            try? realm.write {
                realm.add(object)
            }
        }
    }
    public func loadData<T: Object>(type: T.Type) -> Results<T>? {
        do{
            let realm = try Realm()
            var items = realm.objects(type)
            return items
        } catch{
            print(error)
            }
         return nil
        }
    public func getItems<T: Object>(type: T.Type) -> [T] {
        if let results = getResults(type) {
            return Array(results)
        }
        return []
    }

    public func getResults<T: Object>(_ type: T.Type) -> Results<T>? {
//        var predicate: NSPredicate?
//        var conditionStr = ""
//        var arguments = [Any]()
//        if conditions.count > 0 {
//            for c in conditions {
//                conditionStr.append(conditionStr.isEmpty ? "" : " AND ")
//                switch c.condition {
//                case .equals:
//                    conditionStr.append("\(c.field) = %@")
//                    arguments.append(c.value)
//                case .greater:
//                    conditionStr.append("\(c.field) > %@")
//                    arguments.append(c.value)
//                case .greaterOrEqual:
//                    conditionStr.append("\(c.field) >= %@")
//                    arguments.append(c.value)
//                case .less:
//                    conditionStr.append("\(c.field) < %@")
//                    arguments.append(c.value)
//                case .lessOrEqual:
//                    conditionStr.append("\(c.field) <= %@")
//                    arguments.append(c.value)
//                case .inList:
//                    if let arVal = c.value as? [String] {
//                        conditionStr.append("\(c.field) IN %@")
//                        arguments.append(arVal)
//                    }
//                }
//            }
//            predicate = NSPredicate(format: conditionStr, argumentArray: arguments)
//        }

        do {
            let realm = try Realm()
            var items = realm.objects(type)

//            if let predicate = predicate {
//                items = items.filter(predicate)
//            }
//            if let sorted = sorted {
//                items = items.sorted(by: sorted)
//            }
            return items
        } catch {
            print("error in getResults method")
        }
        return nil
    }

    public func saveOrUpdate<T: Object>(items: [T]) -> [T] {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(items, update: .all)
            }
        } catch {
           print("error in saveOrUpdate Method")
        }
        return items
    }
    
    public func deleteArray<T: Object>(objectsType: T.Type) {

        let items = getItems(type: objectsType)

        for item in items {
            deleteData(object: item)
        }
    }
    public func deleteData<T:Object>(object: T){
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(object)
            }
        } catch {
           print("error deleting object:\(object), ERROR MESSAGE:\(error)")
            }
        }
    }



