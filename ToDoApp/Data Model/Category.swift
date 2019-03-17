//
//  Category.swift
//  ToDoApp
//
//  Created by Vidya Muniraju on 3/16/19.
//  Copyright © 2019 Vidya Muniraju. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    
    @objc dynamic var color : String = ""
    
    let items = List<Item>()
    
    
}
