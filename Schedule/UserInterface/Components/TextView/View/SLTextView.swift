//
//  SLTextView.swift
//  Schedule
//
//  Created by Tatyana Anikina on 26.11.2020.
//

import UIKit

class SLTextView: UITextView {

    public var placeholderLabel: UILabel!

    public var placeholder: String? {
        didSet {
            placeholderLabel?.text = placeholder
        }
    }

    override var text: String! {
        didSet {
            placeholderLabel.isHidden = !text.isEmpty
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        configurePlaceholder()
        configureObserver()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        configurePlaceholderLayout()
    }

    private func configurePlaceholder() {
        placeholderLabel = UILabel()
        placeholderLabel.font = font
        placeholderLabel.text = placeholder
        placeholderLabel.textColor = .placeholderText
        placeholderLabel.isHidden = !text.isEmpty

        addSubview(placeholderLabel)
    }

    private func configurePlaceholderLayout() {
        guard let font = font else { return }

        placeholderLabel.frame = CGRect(x: textContainerInset.left + textContainer.lineFragmentPadding, y: textContainerInset.top, width: textContainer.size.width - (textContainer.lineFragmentPadding * 2), height: font.lineHeight)
    }

    private func configureObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChangeHandler(_:)), name: UITextView.textDidChangeNotification, object: self)
    }

    @IBAction private func textDidChangeHandler(_ notification: Notification) {
        placeholderLabel.isHidden = !text.isEmpty
    }
}

