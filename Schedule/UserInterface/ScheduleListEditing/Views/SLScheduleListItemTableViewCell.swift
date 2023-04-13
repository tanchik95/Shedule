//
//  SLScheduleListItemTableViewCell.swift
//  Schedule
//
//  Created by Tatyana Anikina on 22.11.2020.
//

import UIKit

protocol SLScheduleListItemTableViewCellDelegate: AnyObject {
    func nameFieldTableViewCell(_ nameFieldTableViewCell: SLScheduleListItemTableViewCell, didChangeName name: String)
}

class SLScheduleListItemTableViewCell: UITableViewCell {

    @IBOutlet private var textField: UITextField!

    public weak var delegate: SLScheduleListItemTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        textField.delegate = self 

    }

    public func setContent(_ name: String) {
        textField.text = name
    }

    public var placeholder: String?  {
        set {
            textField.placeholder = newValue
        }
        get {
            return textField.placeholder
        }
    }
}

extension SLScheduleListItemTableViewCell: UITextFieldDelegate {


    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
            let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)

            if updatedText.count <= 25, updatedText.first?.isWhitespace != true {
                delegate?.nameFieldTableViewCell(self, didChangeName: updatedText)

                return true
            } else {
                 textField.animateWithShake()
                
                return false
            }
        } else {
            return true
        }
    }
}
