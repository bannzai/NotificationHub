//
//  SafariViewController.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/06/15.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SwiftUI
import SafariServices

struct SafariView : UIViewControllerRepresentable {
    typealias UIViewControllerType = SFSafariViewController
    
    let url: URL
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SafariView.UIViewControllerType {
        let viewController = SFSafariViewController(url: url)
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {
        uiViewController.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
}

#if DEBUG
struct SafariViewController_Previews : PreviewProvider {
    static var previews: some View {
        SafariView(url: URL(string: "https://github.com/bannzai/")!)
    }
}
#endif
