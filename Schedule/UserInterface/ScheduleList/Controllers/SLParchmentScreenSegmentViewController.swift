//
//  SParchmentScreenSegmentViewController.swift
//  Schedule
//
//  Created by Tatyana Anikina on 18.11.2020.
//

import UIKit

protocol SLParchmentScreenSegmentViewControllerDelegate : AnyObject {
    func segmentViewController(_ segmentViewController: SLParchmentScreenSegmentViewController, pagingItem: CalendarItem, didSelectItemAt indexPath: IndexPath)
    func segmentViewController(_ segmentViewController: SLParchmentScreenSegmentViewController, pagingItem: CalendarItem, didSelectAddPhotoHomeworkFieldInItemAt indexPath: IndexPath)
    func deleteCellinSegment(_ segmentViewController: SLParchmentScreenSegmentViewController, pagingItem: CalendarItem, didDeleteItemAt indexPath: IndexPath)
}

protocol SLParchmentScreenSegmentViewControllerDataSource: class {
    func segmentViewController(_ segmentViewController: SLParchmentScreenSegmentViewController, pagingItem: CalendarItem, numberOfSubjectsInSection section: Int) -> Int
    func segmentViewController(_ segmentViewController: SLParchmentScreenSegmentViewController, pagingItem: CalendarItem, subjectForItemAt indexPath: IndexPath) -> SLSubject?
}

extension SLParchmentScreenSegmentViewController {

    static func instantiateInitialVC(pagingItem: CalendarItem) -> SLParchmentScreenSegmentViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "SLParchmentScreenSegmentViewController") as! SLParchmentScreenSegmentViewController
        viewController.pagingItem = pagingItem

        return viewController
    }
}

class SLParchmentScreenSegmentViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!

    public weak var delegate: SLParchmentScreenSegmentViewControllerDelegate?
    public weak var dataSource: SLParchmentScreenSegmentViewControllerDataSource?

    public private (set) var pagingItem: CalendarItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(UINib.init(nibName: "SLParchmentScreenSegmentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SLParchmentScreenSegmentCollectionViewCell")
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.collectionViewLayout = createLayout()

        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

private func createLayout() -> UICollectionViewLayout {
    let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),heightDimension: .estimated(44))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),heightDimension: .estimated(44))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        var section = NSCollectionLayoutSection(group: group)

        var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        configuration.backgroundColor = .applicationCollectionView
        section = NSCollectionLayoutSection.list(using: configuration, layoutEnvironment: layoutEnvironment)
        section.interGroupSpacing = 8
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 8, bottom: 10, trailing: 8)

        return section
    }
    return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
}

extension SLParchmentScreenSegmentViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let configuration = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { actions -> UIMenu? in
            let action = UIAction(title: "Delete", image: UIImage(systemName: "trash.fill"), attributes: .destructive) { action in
                self.delegate?.deleteCellinSegment(self, pagingItem: self.pagingItem, didDeleteItemAt: indexPath)
                self.collectionView.deleteItems(at: [indexPath])
            }
            return UIMenu(title: "Menu", children: [action])
        }
        return configuration
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.segmentViewController(self, pagingItem: pagingItem, numberOfSubjectsInSection: section) ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SLParchmentScreenSegmentCollectionViewCell", for: indexPath) as! SLParchmentScreenSegmentCollectionViewCell
        if let subject = dataSource?.segmentViewController(self, pagingItem: pagingItem, subjectForItemAt: indexPath) {
            cell.setContent(subject)
            cell.delegate = self
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.segmentViewController(self, pagingItem: pagingItem, didSelectItemAt: indexPath)
    }
}


extension SLParchmentScreenSegmentViewController: SLParchmentScreenSegmentCollectionViewCellDelegate {
    func addPhotoHomeworkFieldOnSegmentViewCell(_ cell: SLParchmentScreenSegmentCollectionViewCell) {
        if let indexPath = collectionView.indexPath(for: cell) {
            delegate?.segmentViewController(self, pagingItem: pagingItem, didSelectAddPhotoHomeworkFieldInItemAt: indexPath)
        }
    }
}

