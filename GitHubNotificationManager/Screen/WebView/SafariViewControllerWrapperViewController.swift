//
//  SafariViewControllerWrapperViewController.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/09/30.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SafariServices
import UIKit

class SafariViewControllerWrapperViewController: UIViewController {
    var url: URL {
        didSet {
            removeChildViewControllerIfNeeded()
            createContentViewcontroller()
        }
    }
    
    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var safariViewController: SafariViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        removeChildViewControllerIfNeeded()
        createContentViewcontroller()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        removeChildViewControllerIfNeeded()
    }
    
    func removeChildViewControllerIfNeeded() {
        if let safariViewController = safariViewController {
            safariViewController.view.constraints.forEach { $0.isActive = false }
            safariViewController.willMove(toParent: self)
            safariViewController.view.removeFromSuperview()
            safariViewController.removeFromParent()
        }
        safariViewController = nil
    }
    
    func createContentViewcontroller() {
        let safariViewController = SafariViewController(url: url)
        safariViewController.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(safariViewController)
        view.addSubview(safariViewController.view)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: safariViewController.view.topAnchor),
            view.bottomAnchor.constraint(equalTo: safariViewController.view.bottomAnchor),
            view.leftAnchor.constraint(equalTo: safariViewController.view.leftAnchor),
            view.rightAnchor.constraint(equalTo: safariViewController.view.rightAnchor),
        ])
        safariViewController.didMove(toParent: self)
        self.safariViewController = safariViewController
    }
}

