//
//  ItemPost+CoreDataProperties.swift
//  WSCRUD
//
//  Created by Victor Peralta on 14/10/23.
//
//

import Foundation
import CoreData


extension ItemPost {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemPost> {
        return NSFetchRequest<ItemPost>(entityName: "ItemPost")
    }

    @NSManaged public var body: String?
    @NSManaged public var id: Int16
    @NSManaged public var title: String?
    @NSManaged public var userId: Int16

}

extension ItemPost : Identifiable {

}
