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
    @objc dynamic var photo : Data? = nil
}
