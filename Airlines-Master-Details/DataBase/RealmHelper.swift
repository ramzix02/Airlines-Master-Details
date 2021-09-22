//
//  RealmHelper.swift
//  Airlines-Master-Details
//
//  Created by Ahmed Ramzy on 22/09/2021.
//

import Foundation
import RealmSwift

class RealmHelper {
    
    static let shared = RealmHelper()
    var realm: Realm!
    
    private init(){
        self.realm = try! Realm()
        print("realm: \(realm.configuration.fileURL)")
    }
    
    func save<T:Object>(objects: [T]){
        do{
            try realm.write {
                realm.add(objects)
            }
        } catch {
            print("Error saving data: \(error)")
        }
    }
    
//    func save(arrListAirlines: [ListAirlinesModel]) {
//        
//        let ListOfAirlines = List<AirlineModel>()
//
//        for airline in arrListAirlines {
//            ListOfAirlines.append(airline)
//        }
//        
//        print("iti \(ListOfAirlines)")
//        
//        realm.beginWrite()
//        realm.add(ListOfAirlines)
//        try! realm.commitWrite()
//        
//    }
    
    func render(){
        let arrAirlines = try! Realm().objects(AirlineModel.self)
        for ailine in arrAirlines{
            print("iti name: \(ailine.name)")
            print("iti id: \(ailine.id)")
        }
    }
    
    func delete() {
        realm.beginWrite()
        realm.delete(try! Realm().objects(AirlineModel.self))
        try! realm.commitWrite()
    }
        
    
}


class AirlineModel : Object{
    @objc dynamic var id: Double = 0.0
    @objc dynamic var name: String = ""
    @objc dynamic var country: String = ""
    @objc dynamic var logo: String = ""
    @objc dynamic var slogan: String = ""
    @objc dynamic var headQuaters: String = ""
    @objc dynamic var website: String = ""
    @objc dynamic var established: String = ""
    @objc dynamic var createdDate: String = ""
    
//    override static func primaryKey() -> String? {
//        "id"
//      }
}
