//
//  SLSubject.swift
//  Schedule
//
//  Created by Tatyana Anikina on 23.12.2020.
//

import Foundation
import UIKit
import CoreData

struct SLSubject {

    public var name: String
    public var homework: String
    public var startTime: String
    public var endTime: String
    public var color: UIColor
    public var dateID: String

    init(name: String, homework: String, startTime: String, endTime: String, color: UIColor, dateID: String) {
        self.name = name
        self.homework = homework
        self.startTime = startTime
        self.endTime = endTime
        self.color = color
        self.dateID = dateID

    }

    init(managedObject: SLSubjectManagerObject) {
        self.name = managedObject.name
        self.homework = managedObject.homework
        self.startTime = managedObject.startTime
        self.endTime = managedObject.endTime
        if let color = UIColor(hex: managedObject.color) {
            self.color = color
        } else {
            self.color = .clear
        }
        self.dateID = managedObject.dateID

    }
}
