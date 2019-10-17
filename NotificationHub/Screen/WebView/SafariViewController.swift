//
//  SafariViewController.swift
//  NotificationHub
//
//  Created by Yudai.Hirose on 2019/09/30.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SafariServices
import UIKit

class SafariViewController: SFSafariViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

extension SafariViewController: SFSafariViewControllerDelegate {
    
}
