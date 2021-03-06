//
//  OAuthView.swift
//  NotificationHub
//
//  Created by Yudai.Hirose on 2019/10/04.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SwiftUI
import NotificationHubRedux

struct OAuthView : UIViewControllerRepresentable {
    typealias UIViewControllerType = UINavigationController

    func makeUIViewController(context: UIViewControllerRepresentableContext<OAuthView>) -> OAuthView.UIViewControllerType {
        let navigationController = UINavigationController()
        let viewController = UIStoryboard(name: "OAuthViewController", bundle: nil).instantiateInitialViewController { (coder) in
            return OAuthViewController(coder: coder, callback: { [weak navigationController] result in
                switch result {
                case .success(let token):
                    sharedStore.dispatch(action: SignupAction(githubAccessToken: token.credential.oauthToken))
                case .failure(let error):
                    navigationController?.present(self.buildAlertController(with: error), animated: true, completion: nil)
                }
            })
        }!
        navigationController.setViewControllers([viewController], animated: false)
        return navigationController
    }
    
    func updateUIViewController(_ uiViewController: OAuthView.UIViewControllerType, context: UIViewControllerRepresentableContext<OAuthView>) {
        
    }
    
    func buildAlertController(with error: Error) -> UIAlertController {
        let alertController = UIAlertController(
            title: "Authorized Error",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            
        }))
        return alertController
    }
}

#if DEBUG
struct OAuthViewController_Previews : PreviewProvider {
    @State static var githubAccessToken: String? = nil
    static var previews: some View {
        OAuthView()
    }
}
#endif
