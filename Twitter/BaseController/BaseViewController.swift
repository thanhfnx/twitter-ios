//
//  BaseViewController.swift
//  Twitter
//
//  Created by Thanh Nguyen Xuan on 10/9/17.
//  Copyright © 2017 Thanh Nguyen Xuan. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		setupLogo()
  		addHideKeyboardWhenTouched()
    }

	private func addHideKeyboardWhenTouched() {
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardWhenTouched))
		view.addGestureRecognizer(tapGesture)
    }

	@objc
	private func hideKeyboardWhenTouched() {
		view.endEditing(true)
    }

	private func setupLogo() {
		let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        imageView.image = #imageLiteral(resourceName: "icon_twitter")
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }

}
