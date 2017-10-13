//
//  CustomTextField.swift
//  Twitter
//
//  Created by Thanh Nguyen Xuan on 10/10/17.
//  Copyright © 2017 Thanh Nguyen Xuan. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {

    var isValid = false

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customTextField()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        customTextField()
    }

    override func didMoveToSuperview() {
        let bottomBorderView = UIView()
        guard let superview = self.superview else {
            return
        }
        superview.addSubview(bottomBorderView)
        bottomBorderView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomBorderView.topAnchor.constraint(equalTo: bottomAnchor),
            bottomBorderView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomBorderView.heightAnchor.constraint(equalToConstant: 0.5),
            bottomBorderView.trailingAnchor.constraint(equalTo: superview.trailingAnchor)
        ])
        bottomBorderView.backgroundColor = .darkGray
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [
            NSAttributedStringKey.foregroundColor: kDefaultTintColor
        ])
    }

    private func customTextField() {
        delegate = self
        borderStyle = .none
        font = .systemFont(ofSize: kDefaultFontSize)
        textColor = kDefaultColor
        autocorrectionType = .no
        spellCheckingType = .no
        if #available(iOS 11.0, *) {
            smartDashesType = .no
            smartInsertDeleteType = .no
            smartQuotesType = .no
        }
    }

}

// MARK: - UITextFieldDelegate

extension CustomTextField: UITextFieldDelegate {

    // TODO: Handle return button

}
