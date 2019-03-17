//
//  Item.swift
//  ToDoApp
//
//  Created by Vidya Muniraju on 3/16/19.
//  Copyright © 2019 Vidya Muniraju. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
