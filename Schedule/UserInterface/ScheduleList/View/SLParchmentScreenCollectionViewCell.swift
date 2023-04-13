//
//  SLParchmentScreenCollectionViewCell.swift
//  Schedule
//
//  Created by Tatyana Anikina on 19.11.2020.
//

import UIKit
import Parchment

class SLParchmentScreenCollectionViewCell: PagingCell {

    @IBOutlet weak var backgraundDate: UIView!
    @IBOutlet weak var dayWeekLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    private var isDateToday: Bool = false


    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
      
    }

    private func configure() {
        backgraundDate.layer.cornerRadius = 6
        backgraundDate.layer.borderWidth = 0
        dayWeekLabel.font = dayWeekLabel.font.withSize(16)
        dateLabel.font = dateLabel.font.withSize(18)
        backgraundDate.layer.borderColor = UIColor(named: "Application Badge Label Color")?.cgColor
    }


    private func updateSelectedState(selected: Bool) {
        if selected {
            backgraundDate.backgroundColor = .applicationSecondaryParchment
            dateLabel.textColor = .applicationBadgeLabel
            dayWeekLabel.textColor = .applicationBadgeLabel
            backgraundDate.layer.borderWidth = 1
        } else {

            if isDateToday {
                dateLabel.textColor = .applicationBadgeLabel
                dayWeekLabel.textColor = .applicationBadgeLabel
                backgraundDate.backgroundColor = .applicationSecondaryParchment
                backgraundDate.layer.borderWidth = 0
            } else {
                backgraundDate.backgroundColor = .applicationSecondaryParchment
                dateLabel.textColor = .systemGray
                dayWeekLabel.textColor = .systemGray
                backgraundDate.layer.borderWidth = 0
            }
        }
    }

    override func setPagingItem(_ pagingItem: PagingItem, selected: Bool, options: PagingOptions) {
        let calendarItem = pagingItem as! CalendarItem
        dateLabel.text = calendarItem.dateText
        dayWeekLabel.text = calendarItem.weekdayText
        isDateToday = Calendar.current.isDateInToday(calendarItem.date)
        updateSelectedState(selected: selected)

    }
}


