//
//  SLScheduleListColorTableViewCell.swift
//  Schedule
//
//  Created by Tatyana Anikina on 22.11.2020.
//

import UIKit

protocol SLScheduleListColorTableViewCellDelegate: AnyObject {
    func colorStrawlTableViewCell(_ colorStrawlTableViewCell: SLScheduleListColorTableViewCell, didChangeColor color: UIColor)
}

class SLScheduleListColorTableViewCell: UITableViewCell {

    @IBOutlet weak var stackView: UIStackView!

    @IBOutlet var buttons: [UIButton]!

    let colors: [UIColor] = [.applicationParchment, .orange, .yellow, .green, .blue, .purple, .lightGray, .systemPink]


    public weak var delegate: SLScheduleListColorTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.layoutIfNeeded()
        layoutView()
    }

    private func layoutView() {
        for button in buttons {
            button.layer.cornerRadius = button.frame.size.width / 2

        }
    }

    public func setSelectedColor(at tag: Int) {
        if let button = buttons.first(where: { $0.tag == tag }) {
            button.layer.borderWidth = 3
            button.layer.borderColor = UIColor(named: "Aplication Subject Cell")?.cgColor
        }
    }
    
    @IBAction func buttonsAction(_ sender: UIButton) {
        delegate?.colorStrawlTableViewCell(self, didChangeColor: colors[sender.tag])
        for button in buttons {
            if sender == button {
                button.layer.borderWidth = 3
                button.layer.borderColor = UIColor(named: "Aplication Subject Cell")?.cgColor
    
            } else {
                button.layer.borderWidth = 0
            }
        }
    }
}

