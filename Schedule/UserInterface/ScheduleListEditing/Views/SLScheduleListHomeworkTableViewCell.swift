//
//  SLScheduleListHomeworkTableViewCell.swift
//  Schedule
//
//  Created by Tatyana Anikina on 26.11.2020.
//

import UIKit

protocol SLScheduleListHomeworkTableViewCellDelegate: AnyObject {
    func homeworkFieldTableViewCell(_ homeworkFieldTableViewCell: SLScheduleListHomeworkTableViewCell, didChangeHomework homework: String?)
    func addPhotoHomeworkFieldTableViewCell() 

}

class SLScheduleListHomeworkTableViewCell: UITableViewCell {

    @IBOutlet weak var addPhotoOutlet: UIButton!

    @IBOutlet weak var textView: SLTextView!

    public weak var delegate: SLScheduleListHomeworkTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        textView.delegate = self
        configureView()
    }

    @IBAction func addPhotoAction(_ sender: UIButton) {
        delegate?.addPhotoHomeworkFieldTableViewCell()
    }


    private func configureView() {
        textView.placeholder = "Homework"
        
    }

    public func setContent(_ text: String?) {
        textView.text = text
    }
}

extension SLScheduleListHomeworkTableViewCell: UITextViewDelegate {


    func textViewDidChange(_ textView: UITextView) {
        let optionalText = textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? nil : textView.text

        delegate?.homeworkFieldTableViewCell(self, didChangeHomework: optionalText)
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if let currentText = textView.text,
            let textRange = Range(range, in: currentText) {
            let updatedText = currentText.replacingCharacters(in: textRange, with: text)

            if updatedText.count <= 140, updatedText.first?.isWhitespace != true, !updatedText.contains("\n") {
                return true
            } else {
//                textView.animateWithShake()

                return false
            }
        } else {
            return true
        }
    }
}
