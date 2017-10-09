//
//  BaseViewController.swift
//  Twitter
//
//  Created by Thanh Nguyen Xuan on 10/9/17.
//  Copyright © 2017 Thanh Nguyen Xuan. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

	@IBOutlet private weak var toolbarViewBottomConstraint: NSLayoutConstraint?
	var cancelButton: UIBarButtonItem?

	// MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLogo()
      	addHideKeyboardWhenTouched()
      	addCancelButtonIfNeeded()
    	navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    	NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)),
        	name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)),
            name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		view.endEditing(true)
	}

	deinit {
		NotificationCenter.default.removeObserver(self)
	}

	private func addHideKeyboardWhenTouched() {
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardWhenTouched))
		view.addGestureRecognizer(tapGesture)
    }

	private func setupLogo() {
		let imageView = UIImageView(image: #imageLiteral(resourceName: "icon_twitter_nav"))
        let view = UIView(frame: imageView.frame)
        view.addSubview(imageView)
        navigationItem.titleView = view
    }

	private func addCancelButtonIfNeeded() {
		if navigationController?.viewControllers.first != self {
			return
		}
		let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self,
			action: #selector(dismissViewController))
		self.cancelButton = cancelButton
		navigationItem.leftBarButtonItem = cancelButton
	}

	@objc
	private func dismissViewController() {
		dismiss(animated: true, completion: nil)
	}

	// MARK: - Keyboard handling.

	@objc
	private func hideKeyboardWhenTouched() {
		view.endEditing(true)
    }

	@objc
	private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue,
        	  let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval else {
      		return
        }
        let keyboardHeight = keyboardFrame.cgRectValue.height
		toolbarViewBottomConstraint?.constant = keyboardHeight
        UIView.animate(withDuration: duration) {
			self.view.layoutIfNeeded()
		}
    }

	@objc
    private func keyboardWillHide(_ notification: Notification) {
		guard let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval else {
      		return
        }
        toolbarViewBottomConstraint?.constant = 0.0
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }

}
