//
//  RequiredTextField.swift
//  Twitter
//
//  Created by Thanh Nguyen Xuan on 10/12/17.
//  Copyright © 2017 Thanh Nguyen Xuan. All rights reserved.
//

import UIKit

class RequiredTextField: CustomTextField {

    @IBInspectable var validImage: UIImage? = nil {
        didSet {
            guard let image = validImage else {
                return
            }
            let imageView = UIImageView(image: image)
            rightView = imageView
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
    }

    @objc
    private func textFieldEditingChanged() {
        isValid = text?.isEmpty == false
        rightViewMode = isValid ? .always : .never
    }

}
