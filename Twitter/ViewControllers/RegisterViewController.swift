//
//  RegisterViewController.swift
//  Twitter
//
//  Created by Thanh Nguyen Xuan on 10/9/17.
//  Copyright © 2017 Thanh Nguyen Xuan. All rights reserved.
//

import UIKit
import ActiveLabel

class RegisterViewController: BaseViewController {

    enum InputType: CustomStringConvertible {

        case phoneNumber
        case email

        var description: String {
            switch self {
            case .phoneNumber:
                return "Use email instead"
            case .email:
                return "Use phone instead"
            }
        }

    }

    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var phoneNumberView: UIView!
    @IBOutlet private weak var emailView: UIView!
    @IBOutlet private weak var descriptionLabel: ActiveLabel!
    @IBOutlet private weak var switchInputTypeLabel: UILabel!
    @IBOutlet private weak var descriptionLabelTopConstraint: NSLayoutConstraint!

    private var currentViewIndex = 0
    private var currentInputType = InputType.phoneNumber
    private var numberOfViews = 0

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        loadRegisterViews()
        setupDescriptionLabel()
        setupTapGesture()
    }

    // MARK: - Setup methods

    private func setupDescriptionLabel() {
        let termOfService = ActiveType.custom(pattern: "\\sTerms of Service\\b")
        let privacyPolicy = ActiveType.custom(pattern: "\\sPrivacy Policy\\b")
        let cookieUse = ActiveType.custom(pattern: "\\sCookie Use\\b")
        descriptionLabel.enabledTypes.removeAll()
        descriptionLabel.enabledTypes.append(termOfService)
        descriptionLabel.enabledTypes.append(privacyPolicy)
        descriptionLabel.enabledTypes.append(cookieUse)
        descriptionLabel.text = descriptionLabel.text ?? ""
        for key in descriptionLabel.enabledTypes {
            descriptionLabel.customColor[key] = kDefaultColor
            descriptionLabel.customSelectedColor[key] = kDefaultColor
        }
    }

    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(switchInputTypeLabelTapped))
        switchInputTypeLabel.addGestureRecognizer(tapGesture)
    }

    private func loadRegisterViews() {
        guard let views = Bundle.main.loadNibNamed("RegisterView", owner: self, options: nil) as? [UIView] else {
            return
        }
        numberOfViews = views.count
        var startX: CGFloat = 0.0
        for view in views {
            view.frame = CGRect(x: startX, y: 0.0, width: scrollView.bounds.width, height: scrollView.bounds.height)
            scrollView.addSubview(view)
            startX += scrollView.bounds.width
        }
    }

    private func animateView(movingForward: Bool = true) {
        if movingForward && currentViewIndex < numberOfViews - 1 {
            currentViewIndex += 1
        } else if !movingForward && currentViewIndex > 0 {
            currentViewIndex -= 1
        } else {
            return
        }
        view.endEditing(true)
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
        if currentViewIndex == 0 {
            navigationItem.setLeftBarButton(cancelButton, animated: true)
            return
        }
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "icon_back_nav"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.setLeftBarButton(backButton, animated: true)
    }

    @objc
    private func backButtonTapped() {
        animateView(movingForward: false)
    }

    @objc
    private func switchInputTypeLabelTapped() {
        let offset = phoneNumberView.bounds.height - emailView.bounds.height
        switch currentInputType {
        case .phoneNumber:
            phoneNumberView.alpha = 0.0
            emailView.alpha = 1.0
            currentInputType = .email
            descriptionLabelTopConstraint.constant -= offset
        case .email:
            phoneNumberView.alpha = 1.0
            emailView.alpha = 0.0
            currentInputType = .phoneNumber
            descriptionLabelTopConstraint.constant += offset
        }
        switchInputTypeLabel.text = currentInputType.description
    }

}
