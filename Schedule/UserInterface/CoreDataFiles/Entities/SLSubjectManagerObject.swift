//
//  SLSubjectManagerObject.swift
//  Schedule
//
//  Created by Tatyana Anikina on 23.12.2020.
//

import CoreData

public class SLSubjectManagerObject: NSManagedObject {

    @NSManaged public var name: String
    @NSManaged public var homework: String
    @NSManaged public var startTime: String
    @NSManaged public var endTime: String
    @NSManaged public var color: String
    @NSManaged public var dateID: String

}

extension SLSubjectManagerObject {

    public static var entityName: String = "SLSubject"

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SLSubjectManagerObject> {
        return NSFetchRequest<SLSubjectManagerObject>(entityName: entityName)
    }
}
