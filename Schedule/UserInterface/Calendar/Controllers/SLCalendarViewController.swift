//
//  SLCalendarViewController.swift
//  Schedule
//
//  Created by Tatyana Anikina on 23.11.2020.
//

import UIKit
import FSCalendar

class SLCalendarViewController: UIViewController {

    var calendar = FSCalendar()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    func configure() {
        calendar = FSCalendar(frame: CGRect(x: 0.0, y: 40.0, width: self.view.frame.size.width, height: 300.0))
        calendar.scrollDirection = .horizontal
        self.view.addSubview(calendar)
    }
}
