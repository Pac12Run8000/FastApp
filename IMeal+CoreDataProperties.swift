//
//  IMeal+CoreDataProperties.swift
//  FastApp
//
//  Created by Michelle Grover on 2/23/16.
//  Copyright © 2016 Michelle Grover. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension IMeal {

    @NSManaged var mealDesc: String?
    @NSManaged var mealInterval: String?
    @NSManaged var mealName: String?

}
