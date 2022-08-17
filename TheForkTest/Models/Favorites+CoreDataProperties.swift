//
//  Favorites+CoreDataProperties.swift
//  TheForkTest
//
//  Created by Max Ward on 17/08/2022.
//
//

import Foundation
import CoreData


extension Favorites {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorites> {
        return NSFetchRequest<Favorites>(entityName: "Favorites")
    }

    @NSManaged public var uuid: String

}

extension Favorites : Identifiable {

}
