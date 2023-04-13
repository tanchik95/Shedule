//
//  SLScheduleListViewController.swift
//  Schedule
//
//  Created by Tatyana Anikina on 22.11.2020.
//

import UIKit
import CoreData

protocol SLScheduleListViewControllerDelegate: AnyObject {

    func scheduleEditorDidCancel(_ scheduleEditor: SLScheduleListViewController)
    func scheduleEditorDidDone(_ scheduleEditor: SLScheduleListViewController, withSchedule subject: SLSubject)
}

extension SLScheduleListViewControllerDelegate {
    func scheduleEditorDidCancel(_ scheduleEditor: SLScheduleListViewController) {
        scheduleEditor.dismiss(animated: true, completion: nil)
    }
}

class SLScheduleListViewController: UIViewController {

    enum Mode {

        case `default`
        case editing(objectId: NSManagedObjectID)
    }

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!

    public weak var delegate: SLScheduleListViewControllerDelegate?

    public var indexPath: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = .applicationTableCell

        doneButton.tintColor = .applicationParchment
        cancelButton.tintColor = .applicationParchment

        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(UINib.init(nibName: "SLScheduleListItemTableViewCell", bundle: nil), forCellReuseIdentifier: "SLScheduleListItemTableViewCell")
        tableView.register(UINib.init(nibName: "SLScheduleListHomeworkTableViewCell", bundle: nil), forCellReuseIdentifier: "SLScheduleListHomeworkTableViewCell")
        tableView.register(UINib.init(nibName: "SLScheduleListTimerStartTableViewCell", bundle: nil), forCellReuseIdentifier: "SLScheduleListTimerStartTableViewCell")
        tableView.register(UINib.init(nibName: "SLScheduleListTimerEndTableViewCell", bundle: nil), forCellReuseIdentifier: "SLScheduleListTimerEndTableViewCell")
        tableView.register(UINib.init(nibName: "SLScheduleListColorTableViewCell", bundle: nil), forCellReuseIdentifier: "SLScheduleListColorTableViewCell")

    }

    public lazy var subject = SLSubject(name: "", homework: "", startTime: "8:00", endTime: "9:30", color: .applicationParchment, dateID: "")

    public var mode: Mode = .default

    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        delegate?.scheduleEditorDidCancel(self)
    }
    @IBAction func doneAction(_ sender: UIBarButtonItem) {
            delegate?.scheduleEditorDidDone(self, withSchedule: subject)

        }
    }

extension SLScheduleListViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 2
        case 3:
            return 1
        default:
            return 0
        }
    }

     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Subject"
        case 1:
            return "Homework"
        case 2:
            return "Timer"
        case 3:
            return ""
        default:
            return ""
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0, indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SLScheduleListItemTableViewCell") as! SLScheduleListItemTableViewCell
            cell.delegate = self
            cell.placeholder = "Subject"

                cell.setContent(subject.name)

            return cell

        } else if indexPath.section == 1, indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SLScheduleListHomeworkTableViewCell") as! SLScheduleListHomeworkTableViewCell
            cell.delegate = self

                cell.setContent(subject.homework)

            return cell

        } else if indexPath.section == 2, indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SLScheduleListTimerStartTableViewCell") as! SLScheduleListTimerStartTableViewCell
            cell.delegate = self

            cell.setContent(subject.startTime)

            return cell

        } else if indexPath.section == 2, indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SLScheduleListTimerEndTableViewCell") as! SLScheduleListTimerEndTableViewCell
            cell.delegate = self

                cell.setContent(subject.endTime)

            return cell

        } else if indexPath.section == 3, indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SLScheduleListColorTableViewCell") as! SLScheduleListColorTableViewCell
            cell.selectionStyle = .none
            cell.delegate = self

            if let tag = cell.colors.firstIndex(where: {$0 == subject.color}) {
                cell.setSelectedColor(at: tag)
            }

            return cell
        } else {
            return UITableViewCell()
        }
    }
}

extension SLScheduleListViewController: SLScheduleListItemTableViewCellDelegate {
    func nameFieldTableViewCell(_ nameFieldTableViewCell: SLScheduleListItemTableViewCell, didChangeName name: String) {
        subject.name = name
        doneButton.isEnabled = name.count > 0
    }
}

extension SLScheduleListViewController: SLScheduleListHomeworkTableViewCellDelegate {
    func addPhotoHomeworkFieldTableViewCell() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SLScheduleListAddPhotoHomeworkViewController") as! SLScheduleListAddPhotoHomeworkViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func homeworkFieldTableViewCell(_ homeworkFieldTableViewCell: SLScheduleListHomeworkTableViewCell, didChangeHomework homework: String?) {
        self.subject.homework = homework ?? ""
    }
}

extension SLScheduleListViewController: SLScheduleListTimeStartTableViewCellDelegate {
    func timeStartDatePickerTableViewCell(_ timeStartDatePickerTableViewCell: SLScheduleListTimerStartTableViewCell, didChangeTimeStart startTime: String) {
        self.subject.startTime = startTime
    }
}

extension SLScheduleListViewController: SLScheduleListTimerEndTableViewCellDelegate {
    func timeEndDatePickerTableViewCell(_ timeEndDatePickerTableViewCell: SLScheduleListTimerEndTableViewCell, didChangeTimeEnd endTime: String) {
        self.subject.endTime = endTime
    }
}

extension SLScheduleListViewController: SLScheduleListColorTableViewCellDelegate {
    func colorStrawlTableViewCell(_ colorStrawlTableViewCell: SLScheduleListColorTableViewCell, didChangeColor color: UIColor) {
        self.subject.color = color
    }
}

