//
//  Date+Formatter.swift
//  Schedule
//
//  Created by Tatyana Anikina on 18.11.2020.
//

import Foundation

extension Date {

    enum Format {
        case short
        case medium
        case date
        case weekday
        case month
        case title
        case dateID
    }

    func format(to format: Format) -> String {
        switch format {
        case .short:
            return shortDateFormatted()
        case .medium:
            return mediumDateFormatted()
        case .date:
            return dateFormatted()
        case .weekday:
            return weekdayFormatter()
        case .month:
            return monthFormatter()
        case .title:
            return titleFormatted()
        case .dateID:
            return dateIDFormatter()
        }
    }

    private func shortDateFormatted() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .short
        return dateFormatter.string(from: self)
    }

    private func mediumDateFormatted() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: self)
    }

    //Формат даты на листах календаря "4", а не "04"
    private func dateFormatted() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter.string(from: self)
    }

    private func weekdayFormatter() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        return dateFormatter.string(from: self)
    }
    //Формат месяца в углу - где переход на календарь, при "MM" было бы "12", а не "December"
    private func monthFormatter() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: self)
    }

    private func dateIDFormatter() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY"
        return dateFormatter.string(from: self)
    }

    private func titleFormatted() -> String {
        let calendar = Calendar.current

        if calendar.isDateInYesterday(self) {
            return "Yesterday"
        } else if calendar.isDateInToday(self) {
            return "Today"
        } else if calendar.isDateInTomorrow(self) {
            return "Tomorrow"
        } else {
            return mediumDateFormatted()
        }
    }
}
