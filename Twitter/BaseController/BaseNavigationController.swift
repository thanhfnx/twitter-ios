//
//  BaseNavigationController.swift
//  Twitter
//
//  Created by Thanh Nguyen Xuan on 10/9/17.
//  Copyright © 2017 Thanh Nguyen Xuan. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.tintColor = kDefaultColor
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
    }
    
}
