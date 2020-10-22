//
//  InBox.swift
//  YourStorage
//
//  Created by Владимир Коваленко on 21.10.2020.
//  Copyright © 2020 Vladimir Kovalenko. All rights reserved.
//

import Foundation
import RealmSwift
class InBox: Object {
    @objc dynamic var things : String? = ""
    @objc dynamic var photos : Data? = nil
    var parentCategory = LinkingObjects(fromType: Boxes.self, property: "inBox")
//    let child = List<Thing>()
}
