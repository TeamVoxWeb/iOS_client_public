//
//  CoreData_Helper.swift
//  CarsDemo
//
//  Created by Abhishek Chaudhari on 07/08/18.
//  Copyright © 2018 Abhishek Chaudhari. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import Alamofire

class CoreData_Helper {
    static let sharedInstance = CoreData_Helper()
    
    let carClassName:String = String(describing: Car.self)
    let contentClassName:String = String(describing: Content.self)
    
    // MARK: - init
    private init() {
        
    }
    
    // MARK: - API sync
    
    func getAllCarData(){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let url = String(format: Constants.API.GET_JSON_DATA_API)
        
        Alamofire.request(url,method: .get, encoding: JSONEncoding.default).responseJSON { response in
            
            let responseJSON = response.result.value as? [String: AnyObject]
            if responseJSON == nil {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                return
            }
            
            let error = responseJSON?["error"] as? [String: AnyObject]
            if error != nil {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                return
            }
            let responceArray = responseJSON?["content"] as? Array<NSDictionary>
            
            for carDict in responceArray!{
                let ingress = carDict["ingress"] as! String
                let id = carDict["id"] as! Int32
                let image = carDict["image"] as! String
                let title = carDict["title"] as! String
                let created = carDict["created"] as! Int32
                let changed = carDict["changed"] as! Int32
                let contentArray = carDict["content"] as? Array<NSDictionary>
                
                let fetchRequest : NSFetchRequest<NSFetchRequestResult>
                
                fetchRequest = Car.fetchRequest()
                
                let predicate = NSPredicate(format: "id = %d", id)
                fetchRequest.predicate = predicate
                
                do {
                    let results = try CoreData_Helper.getContext().fetch(fetchRequest)
                    if(results.count == 0){
                        let carObj: Car = NSEntityDescription.insertNewObject(forEntityName: self.carClassName, into: CoreData_Helper.getContext()) as! Car
                        
                        carObj.ingress = ingress
                        carObj.id = id
                        carObj.image = image
                        carObj.title = title
                        carObj.created = created
                        carObj.changed = changed

                        if (contentArray?.count != 0) {
                            let contentDict = contentArray?.first
                            
                            let contentObj: Content = NSEntityDescription.insertNewObject(forEntityName: self.contentClassName, into: CoreData_Helper.getContext()) as! Content
                            let type = contentDict!["type"] as! String
                            let subject = contentDict!["subject"] as! String
                            let description = contentDict!["description"] as! String
                            
                            contentObj.type=type
                            contentObj.subject=subject
                            contentObj.desc=description

                            carObj.content=contentObj
                        }
                    } else{
                        //get existing object and update data
                        //use changed date to decide if data needs to be updated or ignored //from Abhishek
                        
                        let carObj = results.last as! Car
                        if (carObj.changed != changed){
                            carObj.ingress = ingress
                            carObj.id = id
                            carObj.image = image
                            carObj.title = title
                            carObj.created = created
                            carObj.changed = changed
                            if (contentArray?.count != 0) {
                                let contentDict = contentArray?.first
                                
                                let contentObj: Content = NSEntityDescription.insertNewObject(forEntityName: self.contentClassName, into: CoreData_Helper.getContext()) as! Content
                                let type = contentDict!["type"] as! String
                                let subject = contentDict!["subject"] as! String
                                let description = contentDict!["description"] as! String
                                
                                contentObj.type=type
                                contentObj.subject=subject
                                contentObj.desc=description
                                
                                carObj.content=contentObj
                            }
                        }
                    }
                } catch {
                    let fetchError = error as NSError
                    print(fetchError)
                }
            }
            
            CoreData_Helper.saveContext()
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            print("Data added to coredata successfully")
        }
    }
    
    func deleteAllData()
    {
        
        let managedContext = CoreData_Helper.getContext()
        
        for entity in CoreData_Helper.getManagedObjectModel().entities{
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity.name!)
            fetchRequest.returnsObjectsAsFaults = false
            
            do
            {
                let results = try managedContext.fetch(fetchRequest)
                for managedObject in results
                {
                    let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                    managedContext.delete(managedObjectData)
                }
            } catch let error as NSError {
                print("Detele all data in \(entity) error : \(error) \(error.userInfo)")
            }
            
        }
        CoreData_Helper.saveContext()
    }
    // MARK: - Core Data stack
    
    class func getContext() -> NSManagedObjectContext {
        return CoreData_Helper.persistentContainer.viewContext
    }
    
    class func getManagedObjectModel() -> NSManagedObjectModel {
        return CoreData_Helper.persistentContainer.managedObjectModel
    }
    
    static var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "CarsDemo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    class func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
