//
//  CoreDataHelper.swift
//  Airlines-Master-Details
//
//  Created by Ahmed Ramzy on 22/09/2021.
//

import UIKit
import CoreData

class CoreDataHelper {
    static let shared = CoreDataHelper()
    let managedContext : NSManagedObjectContext
    
    var retrievedData : Array<NSManagedObject> = []
    
    private init() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            managedContext = appDelegate.persistentContainer.viewContext
        }else {
            managedContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        }
        
    }
    
    func insertAllAirlines(arrAirlines:[ListAirlinesModelElement],into entityName: String = "AirlineEntity") -> Void {
        
        deleteAllAirlines()
        
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext)
        for airline in arrAirlines {
            let airlineToInsert = NSManagedObject(entity: entity!, insertInto: managedContext)
            
            airlineToInsert.setValue(airline.name, forKey: CoreDataConstants.name.rawValue)
            airlineToInsert.setValue(airline.id, forKey: CoreDataConstants.id.rawValue)
            airlineToInsert.setValue(airline.country, forKey: CoreDataConstants.country.rawValue)
            airlineToInsert.setValue(airline.logo, forKey: CoreDataConstants.logo.rawValue)
            airlineToInsert.setValue(airline.slogan, forKey: CoreDataConstants.slogan.rawValue)
            airlineToInsert.setValue(airline.headQuaters, forKey: CoreDataConstants.headQuaters.rawValue)
            airlineToInsert.setValue(airline.website, forKey: CoreDataConstants.website.rawValue)
            
            do{
                try managedContext.save()
            } catch let error as NSError {
                print(error)
            }
        }
        
    }
    
    private func deleteAllAirlines(entityName : String = "AirlineEntity") -> Void{
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName : entityName)
        if let result = try? managedContext.fetch(fetchRequest) {
            for object in result {
                managedContext.delete(object)
                do{
                    try managedContext.save()
                } catch let error as NSError {
                    print(error)
                }
            }
        }
    }
    
    func retriveAllAirlines(entityName : String = "AirlineEntity") -> [ListAirlinesModelElement] {
        
        var arrAirlines = [ListAirlinesModelElement]()
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName : entityName)
        
        do {
            retrievedData = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print(error)
        }
        if retrievedData.count != 0 {
            arrAirlines = retrievedData.compactMap {
                ListAirlinesModelElement(
                    id: ($0.value(forKey:CoreDataConstants.id.rawValue) as? Double) ?? -1,
                    name: ($0.value(forKey: CoreDataConstants.name.rawValue) as? String) ?? "",
                    country: ($0.value(forKey: CoreDataConstants.country.rawValue) as? String) ?? "",
                    logo: ($0.value(forKey: CoreDataConstants.logo.rawValue) as? String) ?? "",
                    slogan: ($0.value(forKey: CoreDataConstants.slogan.rawValue) as? String) ?? "",
                    headQuaters: ($0.value(forKey: CoreDataConstants.headQuaters.rawValue) as? String) ?? "",
                    website: ($0.value(forKey: CoreDataConstants.website.rawValue) as? String) ?? ""
                )
            }
        }
        return arrAirlines
    }
    
    
}
