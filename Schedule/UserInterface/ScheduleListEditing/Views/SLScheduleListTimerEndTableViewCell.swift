//
//  SLScheduleListTimerEndTableViewCell.swift
//  Schedule
//
//  Created by Tatyana Anikina on 23.11.2020.
//

import UIKit

protocol SLScheduleListTimerEndTableViewCellDelegate: AnyObject {
    func timeEndDatePickerTableViewCell(_ timeEndDatePickerTableViewCell: SLScheduleListTimerEndTableViewCell, didChangeTimeEnd timeEnd: String)
}

class SLScheduleListTimerEndTableViewCell: UITableViewCell {
    @IBOutlet weak var timerEnd: UIDatePicker!

    private var timeString: String = ""

    public weak var delegate: SLScheduleListTimerEndTableViewCellDelegate?


    override func awakeFromNib() {
        super.awakeFromNib()
        timerEnd.datePickerMode = .time
        timerEnd.tintColor = .applicationParchment

    }

    @IBAction private func timeChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let selectedDate = dateFormatter.string(from: sender.date)
        timeString = selectedDate
        delegate?.timeEndDatePickerTableViewCell(self, didChangeTimeEnd: timeString)

    }

    public func setContent(_ text: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let dateString = dateFormatter.date(from: text)!
        timerEnd.setDate(dateString, animated: true)
    }
}
