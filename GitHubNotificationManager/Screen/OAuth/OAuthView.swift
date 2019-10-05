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
        let navigationController = UINavigationController()
        let viewController = UIStoryboard(name: "OAuthViewController", bundle: nil).instantiateInitialViewController { (coder) in
            return OAuthViewController(coder: coder, callback: { [weak navigationController] result in
                switch result {
                case .success(let token):
                    self.isAuthorized = true
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
    static var previews: some View {
        OAuthView(isAuthorized: State(initialValue: false).projectedValue)
    }
}
#endif
