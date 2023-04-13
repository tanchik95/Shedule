//
//  SParchmentScreenSegmentCollectionViewCell.swift
//  Schedule
//
//  Created by Tatyana Anikina on 18.11.2020.
//

import UIKit

protocol SLParchmentScreenSegmentCollectionViewCellDelegate: AnyObject {
    func addPhotoHomeworkFieldOnSegmentViewCell(_ cell: SLParchmentScreenSegmentCollectionViewCell)
}

class SLParchmentScreenSegmentCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var colorViewStrawl: UIView!
    
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var homeworkLabel: UILabel!
    @IBOutlet weak var timeStartLable: UILabel!
    @IBOutlet weak var timeEndLabel: UILabel!
    @IBOutlet weak var colorView: UIView!


    public weak var delegate: SLParchmentScreenSegmentCollectionViewCellDelegate?

    @IBOutlet weak var addPhotoOutlet: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }

    func configure() {
        subjectLabel.highlightedTextColor = .applicationTextColor
        subjectLabel.textColor = .applicationTextColor
        homeworkLabel.textColor = .applicationTextColor
        timeStartLable.textColor = .applicationTextColor
        timeEndLabel.textColor = .applicationTextColor
        colorView.backgroundColor = .applicationSubjectCell
        addPhotoOutlet.imageView?.tintColor = .applicationTextColor

    
    }

    @IBAction func addPhotoAction(_ sender: UIButton) {
        delegate?.addPhotoHomeworkFieldOnSegmentViewCell(self)
    }
    
    public func setContent(_ subject: SLSubject) {
        subjectLabel.text = subject.name
        homeworkLabel.text = subject.homework
        timeStartLable.text = subject.startTime
        timeEndLabel.text = subject.endTime
        colorViewStrawl.backgroundColor = subject.color
    }
}


