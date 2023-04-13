//
//  NSManagedObjectContext + SLSubject.swift
//  Schedule
//
//  Created by Tatyana Anikina on 23.12.2020.
//

import CoreData

extension NSManagedObjectContext {

    @discardableResult func create(with subject: SLSubject) -> SLSubjectManagerObject {
        let object = SLSubjectManagerObject(context: self)

        object.name = subject.name
        object.homework = subject.homework
        object.startTime = subject.startTime
        object.endTime = subject.endTime

        if let color = subject.color.toHex() {
            object.color = color
        } else {
            object.color = "00000000"
        }
        object.dateID = subject.dateID

        return object
    }


    func createAndSave(with subject: SLSubject, completion: ((Result<SLSubjectManagerObject, Error>) -> Void)? = nil) {
        let object = create(with: subject)

        save(completion: { (result) in
            switch result {
            case .success:
                completion?(.success(object))
            case .failure(let error):
                completion?(.failure(error))
            }
        })
    }

    func find(with subject: SLSubject) -> [SLSubjectManagerObject] {
        let fetchRequest: NSFetchRequest<SLSubjectManagerObject> = SLSubjectManagerObject.fetchRequest()

        let namePredicate = NSPredicate(format: "name = %@", subject.name)
        let homeworkPredicate = NSPredicate(format: "homework = %@", subject.homework)
        let startTimePredicate = NSPredicate(format: "startTime = %@", subject.startTime)
        let endTimePredicate = NSPredicate(format: "endTime = %@", subject.endTime)
        let colorPredicate = NSPredicate(format: "color = %@", subject.color)
        let dateIDPredicate = NSPredicate(format: "dateID = %@", subject.dateID)

        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [namePredicate, homeworkPredicate, startTimePredicate, endTimePredicate, colorPredicate, dateIDPredicate])

        do {
            return try fetch(fetchRequest)
        } catch {
            return []
        }
    }

    func findOrCreate(with subject: SLSubject) -> SLSubjectManagerObject {
        let subjects = find(with: subject)

        if subjects.count > 0 {
            return subjects[0]
        } else {
            return create(with: subject)
        }
    }

    func findOrCreateAndSave(with subject: SLSubject, completion: ((Result<SLSubjectManagerObject, Error>) -> Void)? = nil) {
        let object = findOrCreate(with: subject)

        save(completion: { (result) in
            switch result {
            case .success:
                completion?(.success(object))
            case .failure(let error):
                completion?(.failure(error))
            }
        })
    }

    @discardableResult func update(with subject: SLSubject, at objectId: NSManagedObjectID) -> SLSubjectManagerObject {
        let object = self.object(with: objectId) as! SLSubjectManagerObject

        object.name = subject.name
        object.homework = subject.homework
        object.startTime = subject.startTime
        object.endTime = subject.endTime

        if let color = subject.color.toHex() {
            object.color = color
        } else {
            object.color = "00000000"
        }
        object.dateID = subject.dateID

        return object
    }

    func updateAndSave(with subject: SLSubject, at objectId: NSManagedObjectID, completion: ((Result<SLSubjectManagerObject, Error>) -> Void)? = nil) {
        let object = update(with: subject, at: objectId)

        save(completion: { (result) in
            switch result {
            case .success:
                completion?(.success(object))
            case .failure(let error):
                completion?(.failure(error))
            }
        })
    }
}
