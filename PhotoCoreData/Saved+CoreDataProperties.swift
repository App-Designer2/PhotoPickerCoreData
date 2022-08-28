//
//  Saved+CoreDataProperties.swift
//  PhotoCoreData
//
//  Created by App Designer2 on 22.08.22.
//
//

import Foundation
import CoreData


extension Saved {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Saved> {
        return NSFetchRequest<Saved>(entityName: "Saved")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: UUID?
    @NSManaged public var selectedImg: Data?
    @NSManaged public var isLiked: Bool
    
    

}

extension Saved : Identifiable {

}
