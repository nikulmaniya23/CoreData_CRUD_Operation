//
//  CoreManager.swift
//  CoreDataDemo
//
//  Created by iMac on 27/10/20.
//  Copyright © 2020 Nikul. All rights reserved.
//

import CoreData
import UIKit
class CoreManager: NSObject {
    static let shared = CoreManager()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let fetchReq = NSFetchRequest<NSFetchRequestResult>.init(entityName: "User")
    // Fetch Data From User Entity
    func fetchData(completion: @escaping ([NSManagedObject]) -> Void) {
        let managedObject = appDelegate.persistentContainer.viewContext

        do {
            let data = try! managedObject.fetch(fetchReq)
            completion((data as? [NSManagedObject])!)
        }
    }

    // Save Record
    func saveUserData(firstName: String, lastName: String, avtarImage: UIImage?, completion: @escaping (_ success: Bool) -> Void) {
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)

        let user = NSManagedObject(entity: entity!, insertInto: managedContext)
        user.setValue(firstName, forKey: "firstname")
        user.setValue(lastName, forKey: "lastname")
        user.setValue(avtarImage?.pngData(), forKey: "imagedata")

        do {
            try! managedContext.save()
            print("Saved successfully")
            completion(true)
        } catch let err {
            completion(false)
        }
    }

    func updateDataByName(searchText: String, firstName: String, lastName: String, completion: @escaping (_ success: Bool) -> Void) {
        let managedObject = appDelegate.persistentContainer.viewContext
        let fetchReq = NSFetchRequest<NSFetchRequestResult>.init(entityName: "User")
        fetchReq.predicate = NSPredicate(format: "firstname = %@", searchText)

        do {
            let data = try! managedObject.fetch(fetchReq)
            if data.count == 0 {
                print("Not found")
                completion(false)
                return
            }
            let obj = data[0] as! NSManagedObject
            obj.setValue(firstName, forKey: "firstname")
            obj.setValue(lastName, forKey: "lastname")
            try? managedObject.save()
            completion(true)
        }
    }

    func searchRecord(searchText: String, completion: @escaping (_ success: Bool, _ managedObj: [NSManagedObject?]) -> Void) {
        let managedObject = appDelegate.persistentContainer.viewContext
        let fetchReq = NSFetchRequest<NSFetchRequestResult>.init(entityName: "User")
        fetchReq.predicate = NSPredicate(format: "firstname = %@", searchText)
        do {
            let data = try! managedObject.fetch(fetchReq)
            if data.count == 0 {
                completion(false, [])
                return
            } else {
                completion(false, (data as? [NSManagedObject])!)
            }
        }
    }

    func deleteDataByName(searchText: String, completion: @escaping (_ success: Bool) -> Void) {
        let managedObject = appDelegate.persistentContainer.viewContext
        let fetchReq = NSFetchRequest<NSFetchRequestResult>.init(entityName: "User")
        fetchReq.predicate = NSPredicate(format: "firstname = %@", searchText)
        do {
            let data = try! managedObject.fetch(fetchReq)
            if data.count > 0 {
                managedObject.delete(data[0] as! NSManagedObject)
                try? managedObject.save()
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
