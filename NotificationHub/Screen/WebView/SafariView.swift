//
//  SafariViewController.swift
//  NotificationHub
//
//  Created by Yudai.Hirose on 2019/06/15.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SwiftUI
import SafariServices

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

struct SafariViewController_Previews : PreviewProvider {
    static var previews: some View {
        SafariView(url: URL(string: "https://github.com/bannzai/")!)
    }
}

