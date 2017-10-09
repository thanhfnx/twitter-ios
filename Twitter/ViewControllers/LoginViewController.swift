//
//  LoginViewController.swift
//  Twitter
//
//  Created by Thanh Nguyen Xuan on 10/9/17.
//  Copyright © 2017 Thanh Nguyen Xuan. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    @IBOutlet private weak var toolbarViewBottomConstraint: NSLayoutConstraint!

	// MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)),
        	name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)),
            name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

	// MARK: - IBAction

    @IBAction private func cancelButtonTapped(_ sender: Any) {
		dismiss(animated: true, completion: nil)
    }

	// MARK: - Keyboard handling.

	@objc
	private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue,
        	  let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval else {
      		return
        }
        let keyboardHeight = keyboardFrame.cgRectValue.height
		toolbarViewBottomConstraint.constant = keyboardHeight
        UIView.animate(withDuration: duration) {
			self.view.layoutIfNeeded()
		}
    }

	@objc
    private func keyboardWillHide(_ notification: Notification) {
		guard let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval else {
      		return
        }
        toolbarViewBottomConstraint.constant = 0.0
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }

}
