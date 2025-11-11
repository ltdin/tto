//
//  NotificationViewController.swift
//  NetcoreContentService
//
//  Created by Rivercrane Vietnam on 10/03/2022.
//  Copyright © 2022 The Chromium Authors. All rights reserved.
//


import UIKit
import SmartPush

class NotificationViewController: SMTCustomNotificationViewController {
    
    @IBOutlet var customPNView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customView = customPNView
    }
}

