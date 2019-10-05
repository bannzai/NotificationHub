//
//  OAuthView.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/10/04.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SwiftUI
struct OAuthView : UIViewControllerRepresentable {
    typealias UIViewControllerType = UINavigationController
    @Binding var isAuthorized: Bool

    func makeUIViewController(context: UIViewControllerRepresentableContext<OAuthView>) -> OAuthView.UIViewControllerType {
        let viewController = UIStoryboard(name: "OAuthViewController", bundle: nil).instantiateInitialViewController { (coder) in
            return OAuthViewController(coder: coder, callback: { _ in
                self.isAuthorized = true
            })
        }!
        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }
    
    func updateUIViewController(_ uiViewController: OAuthView.UIViewControllerType, context: UIViewControllerRepresentableContext<OAuthView>) {
        
    }
}

#if DEBUG
struct OAuthViewController_Previews : PreviewProvider {
    static var previews: some View {
        OAuthView(isAuthorized: State(initialValue: false).projectedValue)
    }
}
#endif
