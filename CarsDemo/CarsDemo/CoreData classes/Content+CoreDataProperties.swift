//
//  Content+CoreDataProperties.swift
//  
//
//  Created by Abhishek Chaudhari on 07/08/18.
//
//

import Foundation
import CoreData


extension Content {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Content> {
        return NSFetchRequest<Content>(entityName: "Content")
    }

    @NSManaged public var desc: String?
    @NSManaged public var subject: String?
    @NSManaged public var type: String?
    @NSManaged public var car: Car?

}
