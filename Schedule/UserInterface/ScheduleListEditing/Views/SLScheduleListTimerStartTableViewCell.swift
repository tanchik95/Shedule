//
//  SLScheduleListTimerStartTableViewCell.swift
//  Schedule
//
//  Created by Tatyana Anikina on 23.11.2020.
//

import UIKit

protocol SLScheduleListTimeStartTableViewCellDelegate: AnyObject {
    func timeStartDatePickerTableViewCell(_ timeStartDatePickerTableViewCell: SLScheduleListTimerStartTableViewCell, didChangeTimeStart timeStart: String)
}

class SLScheduleListTimerStartTableViewCell: UITableViewCell {

    @IBOutlet weak var timerStart: UIDatePicker!

    private var timeString: String = ""

    public weak var delegate: SLScheduleListTimeStartTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        timerStart.datePickerMode = .time
        timerStart.tintColor = .applicationParchment
    }

    @IBAction private func timeChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let selectedDate = dateFormatter.string(from: sender.date)
        timeString = selectedDate
        delegate?.timeStartDatePickerTableViewCell(self, didChangeTimeStart: timeString)

    }

    public func setContent(_ text: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let dateString = dateFormatter.date(from: text)!
        timerStart.setDate(dateString, animated: true)
    }
}
