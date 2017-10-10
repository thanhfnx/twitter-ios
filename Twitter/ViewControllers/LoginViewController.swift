//
//  LoginViewController.swift
//  Twitter
//
//  Created by Thanh Nguyen Xuan on 10/9/17.
//  Copyright © 2017 Thanh Nguyen Xuan. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IBAction
    
    @IBAction private func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
