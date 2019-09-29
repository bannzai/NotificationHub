//
//  SafariViewController.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/06/15.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SwiftUI
import SafariServices

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

struct SafariView : UIViewControllerRepresentable {
    typealias UIViewControllerType = SafariViewControllerWrapperViewController

    let url: URL
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SafariView.UIViewControllerType {
        let viewController = SafariView.UIViewControllerType(url: url)
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: SafariView.UIViewControllerType, context: UIViewControllerRepresentableContext<SafariView>) {
        uiViewController.url = url
    }
}

#if DEBUG
struct SafariViewController_Previews : PreviewProvider {
    static var previews: some View {
        SafariView(url: URL(string: "https://github.com/bannzai/")!)
    }
}
#endif
