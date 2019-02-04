//
//  Car+CoreDataProperties.swift
//  
//
//  Created by Abhishek Chaudhari on 09/08/18.
//
//

import Foundation
import CoreData


extension Car {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Car> {
        return NSFetchRequest<Car>(entityName: "Car")
    }

    @NSManaged public var created: Int32
    @NSManaged public var id: Int32
    @NSManaged public var image: String?
    @NSManaged public var ingress: String?
    @NSManaged public var title: String?
    @NSManaged public var changed: Int32
    @NSManaged public var content: Content?

}
