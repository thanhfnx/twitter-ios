//
//  RegisterViewController.swift
//  Twitter
//
//  Created by Thanh Nguyen Xuan on 10/9/17.
//  Copyright © 2017 Thanh Nguyen Xuan. All rights reserved.
//

import UIKit

class RegisterViewController: BaseViewController {

	@IBOutlet private weak var scrollView: UIScrollView!

	private var currentViewIndex = 0

	// MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        loadRegisterViews()
    }

	// MARK: - Setup methods

	private func loadRegisterViews() {
		guard let views = Bundle.main.loadNibNamed("RegisterView", owner: self, options: nil) as? [UIView] else {
			return
		}
		var startX: CGFloat = 0.0
		for view in views {
			view.frame = CGRect(x: startX, y: 0.0, width: scrollView.bounds.width, height: scrollView.bounds.height)
			scrollView.addSubview(view)
			startX += scrollView.bounds.width
		}
	}

	private func animateView(movingForward: Bool = true) {
		view.endEditing(true)
		if movingForward {
			currentViewIndex += 1
		} else {
			currentViewIndex -= 1
		}
		let nextOffsetX = CGFloat(currentViewIndex) * scrollView.bounds.width
		UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseIn, animations: {
			self.scrollView.contentOffset = CGPoint(x: nextOffsetX, y: 0.0)
		}, completion: nil)
		showHideBackButton()
	}

	// MARK: - IBAction

	@IBAction private func nextButtonTapped(_ sender: Any) {
		animateView()
	}

	private func showHideBackButton() {
		if currentViewIndex != 0 {
			let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "icon_back_nav"), style: .plain, target: self,
				action: #selector(backButtonTapped))
			navigationItem.setLeftBarButton(backButton, animated: true)
		} else {
			navigationItem.setLeftBarButton(cancelButton, animated: true)
		}
	}

	@objc
	private func backButtonTapped() {
		animateView(movingForward: false)
	}

}
