//
//  ParchmentCalendar.swift
//  Schedule
//
//  Created by Tatyana Anikina on 18.11.2020.
//

import Foundation
import Parchment

struct CalendarItem: PagingItem ,Hashable, Comparable {

    let date: Date
    // Число на листе календаря
    let dateText: String
    let dateID: String
    let weekdayText: String
    let monthText: String
    var title: String

    init(date: Date) {
        self.date = date
        self.dateText = date.format(to: .date)
        self.weekdayText = date.format(to: .weekday)
        self.monthText = date.format(to: .month)
        self.title = date.format(to: .title)
        self.dateID = date.format(to: .dateID)
    }

    static func < (lhs: CalendarItem, rhs: CalendarItem) -> Bool {
      return lhs.date < rhs.date
    }

}


