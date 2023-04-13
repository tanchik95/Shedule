//
//  SParchmentScreenViewController.swift
//  Schedule
//
//  Created by Tatyana Anikina on 18.11.2020.
//

import UIKit
import Parchment
import FSCalendar
import CoreData

class SLParchmentScreenViewController: UIViewController {

    @IBOutlet weak var calendarBarButtomItem: UIBarButtonItem!
    @IBOutlet weak var addItemButtom: UIButton!
    private let pagingCollectionViewController = PagingViewController()
    private let currentDate = Date()
    private var calendarItem = CalendarItem(date: Date())

    var selected = [IndexPath]()

    public var days: [String: [SLSubject]] = [:]

    private var managerObjectContext = CoreDataManager.shared.subjectManagedObjectContext
    private var subjectFetchedResultsController: NSFetchedResultsController<SLSubjectManagerObject>!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureFetchResultController()

        addItemButtom.backgroundColor = .applicationParchment
        calendarBarButtomItem.tintColor = .applicationParchment
        title = calendarItem.title
        calendarBarButtomItem.title = calendarItem.monthText
        configure(pagingCollectionViewController: pagingCollectionViewController)
        layoutView()

    }

    private func configureFetchResultController() {
        let fetchRequest: NSFetchRequest<SLSubjectManagerObject> = SLSubjectManagerObject.fetchRequest()

        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "startTime", ascending: true)]

        subjectFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managerObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        subjectFetchedResultsController.delegate = self

        do {
            try subjectFetchedResultsController.performFetch()
            if let objects = subjectFetchedResultsController.fetchedObjects {
                for object in objects {
                    let dateID = object.dateID
                    let subject = SLSubject(managedObject: object)
                    if days.keys.contains(dateID) {
                        days[dateID]?.insert(subject, at: 0)
                    } else {
                        days[dateID] = [subject]
                    }
                }
            }
            pagingCollectionViewController.reloadData()
        } catch let error {
            print(error.localizedDescription)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "SLScheduleListViewController":
            if let navigationController = segue.destination as? UINavigationController,
                let scheduleEditorViewController = navigationController.viewControllers[0] as? SLScheduleListViewController {

                scheduleEditorViewController.delegate = self

                if let scheduleInfo = sender as? [String: Any] {
                    scheduleEditorViewController.subject = (scheduleInfo["subject"] as? SLSubject)!
                    scheduleEditorViewController.indexPath = scheduleInfo["indexPath"] as? IndexPath
                }
            }
        default:
            break
        }
    }

    private func configure (pagingCollectionViewController: PagingViewController) {

        let cellsCount = 8
        let _ = cellsCount
        let itemSpacing = 12

        pagingCollectionViewController.register(UINib.init(nibName: "SLParchmentScreenCollectionViewCell", bundle: nil), for: CalendarItem.self)

        guard let navigationController = navigationController else { return }
        navigationController.navigationBar.shadowImage = UIImage()

        addChild(pagingCollectionViewController)
        view.insertSubview(pagingCollectionViewController.view, belowSubview: addItemButtom)
        pagingCollectionViewController.didMove(toParent: self)

        pagingCollectionViewController.menuItemSpacing = CGFloat(itemSpacing)
        pagingCollectionViewController.menuItemSize = .fixed(width: 44, height: 58)
        pagingCollectionViewController.menuBackgroundColor = .applicationBackground
        pagingCollectionViewController.indicatorOptions = .hidden
        pagingCollectionViewController.borderOptions = .hidden

        pagingCollectionViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pagingCollectionViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pagingCollectionViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pagingCollectionViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pagingCollectionViewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        ])

        pagingCollectionViewController.infiniteDataSource = self
        pagingCollectionViewController.delegate = self

        pagingCollectionViewController.select(pagingItem: CalendarItem(date: currentDate))

        let separator = UIView()
        view.addSubview(separator)
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .separator

        NSLayoutConstraint.activate([
            separator.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            separator.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            separator.heightAnchor.constraint(equalToConstant: 0.5),
        ])
    }

    private func layoutView() {
        addItemButtom.layer.cornerRadius = addItemButtom.bounds.height / 2
    }
}


extension SLParchmentScreenViewController: PagingViewControllerInfiniteDataSource {

    func pagingViewController(_ pagingViewController: PagingViewController, viewControllerFor pagingItem: PagingItem) -> UIViewController {
        let vc = SLParchmentScreenSegmentViewController.instantiateInitialVC(pagingItem: pagingItem as! CalendarItem)
        vc.dataSource = self
        vc.delegate = self
        return vc
    }

    func pagingViewController(_: PagingViewController, itemBefore pagingItem: PagingItem) -> PagingItem? {
        let calendarItem = pagingItem as! CalendarItem
        return CalendarItem(date: calendarItem.date.addingTimeInterval(-86400))
    }

    func pagingViewController(_: PagingViewController, itemAfter pagingItem: PagingItem) -> PagingItem? {
        let calendarItem = pagingItem as! CalendarItem
        return CalendarItem(date: calendarItem.date.addingTimeInterval(86400))
    }
}

extension SLParchmentScreenViewController: PagingViewControllerDelegate {

    func pagingViewController(_ pagingViewController: PagingViewController, didScrollToItem pagingItem: PagingItem, startingViewController: UIViewController?, destinationViewController: UIViewController, transitionSuccessful: Bool) {
        let calendarItem = pagingItem as! CalendarItem

        title = calendarItem.title
        calendarBarButtomItem.title = calendarItem.monthText
    }    
}

extension SLParchmentScreenViewController: SLScheduleListViewControllerDelegate {

    func scheduleEditorDidDone(_ scheduleEditor: SLScheduleListViewController, withSchedule subject: SLSubject) {
        scheduleEditor.dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            var subject = subject
            if let currenController = self.pagingCollectionViewController.pageViewController.selectedViewController as? SLParchmentScreenSegmentViewController,
                let dateID = currenController.pagingItem?.dateID {
                    subject.dateID = dateID
                }

            switch scheduleEditor.mode {
            case .default:
                self.managerObjectContext.createAndSave(with: subject, completion: { result in
                    switch result {
                    case .success:
                        print("Was created a subject\(subject)")
                    case .failure(let error):
                        print("There was an errer\(error)")
                    }
                })
            case .editing(let objectId):
                self.managerObjectContext.updateAndSave(with: subject, at: objectId, completion: { result in
                    switch result {
                    case .success:
                        print("Was update a subject\(subject)")
                    case .failure(let error):
                        print("There was an errer at update subject\(error)")
                    }
                })
            }
        }

    if let currenController = pagingCollectionViewController.pageViewController.selectedViewController as? SLParchmentScreenSegmentViewController {
        let dateID = currenController.pagingItem?.dateID
            if let indexPath = scheduleEditor.indexPath {
                days[dateID ?? ""]?[indexPath.row] = subject
                currenController.collectionView.reloadItems(at: [indexPath])
            } else {
                if days.keys.contains(dateID!) {
                   days[dateID ?? ""]?.insert(subject, at: 0)
                } else {
                   days[dateID ?? ""] = [subject]
                }
                currenController.collectionView.insertItems(at: [IndexPath(row: 0, section: 0)])
            }
        }
    }
}

extension SLParchmentScreenViewController: SLParchmentScreenSegmentViewControllerDelegate {
    func deleteCellinSegment(_ segmentViewController: SLParchmentScreenSegmentViewController, pagingItem: CalendarItem, didDeleteItemAt indexPath: IndexPath) {
            days[pagingItem.dateID]?.remove(at: indexPath.row)
    }

    
    func segmentViewController(_ segmentViewController: SLParchmentScreenSegmentViewController, pagingItem: CalendarItem, didSelectItemAt indexPath: IndexPath) {
        if let subject = days[pagingItem.dateID]?[indexPath.row] {
            let scheduleInfo: [String: Any] = ["subject": subject, "indexPath": indexPath]
            performSegue(withIdentifier: "SLScheduleListViewController", sender: scheduleInfo)
        }
    }

    func segmentViewController(_ segmentViewController: SLParchmentScreenSegmentViewController, pagingItem: CalendarItem, didSelectAddPhotoHomeworkFieldInItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SLScheduleListAddPhotoHomeworkViewController") as! SLScheduleListAddPhotoHomeworkViewController
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension SLParchmentScreenViewController: SLParchmentScreenSegmentViewControllerDataSource {

    func segmentViewController(_ segmentViewController: SLParchmentScreenSegmentViewController, pagingItem: CalendarItem, numberOfSubjectsInSection section: Int) -> Int {
        return days[pagingItem.dateID]?.count ?? 0
    }

    func segmentViewController(_ segmentViewController: SLParchmentScreenSegmentViewController, pagingItem: CalendarItem, subjectForItemAt indexPath: IndexPath) -> SLSubject? {
        if let subject = days[pagingItem.dateID]?[indexPath.row] {
            return subject
        } else {
            return nil
        }
    }
}

extension SLParchmentScreenViewController: NSFetchedResultsControllerDelegate {

}

