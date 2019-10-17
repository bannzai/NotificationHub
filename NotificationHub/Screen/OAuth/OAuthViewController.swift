//
//  OAuthViewController.swift
//  NotificationHub
//
//  Created by Yudai.Hirose on 2019/10/04.
//  Copyright © 2019 bannzai. All rights reserved.
//

import UIKit
import OAuthSwift
import NotificationHubCore
import AuthenticationServices

public typealias OAuthCallBackType = (Result<OAuthSwift.TokenSuccess, OAuthSwiftError>) -> Void
public class OAuthViewController: UIViewController {
    struct Const {
        static let callbackHost = "oauth-callback"
    }
    
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var logoImageView: UIImageView!
    let oauth: OAuth2Swift = OAuth2Swift(
        consumerKey: Secret.GitHub.clientId,
        consumerSecret: Secret.GitHub.clientSecret,
        authorizeUrl: "https://github.com/login/oauth/authorize",
        accessTokenUrl: "https://github.com/login/oauth/access_token",
        responseType: "code"
    )
    
    let callback: OAuthCallBackType
    init?(coder: NSCoder, callback: @escaping OAuthCallBackType) {
        self.callback = callback
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        signupButton.layer.cornerRadius = 6
        signupButton.layer.borderWidth = 0.5
        signupButton.layer.borderColor = UIColor.systemGray4.cgColor
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func signupButtonPressed(_ sender: Any) {
        authorize()
    }

    func authorize() {
        oauth.authorizeURLHandler = SafariURLHandler(
            viewController: self,
            oauthSwift: oauth
        )
        oauth.authorize(
            withCallbackURL: URL(string: Secret.Application.callbackURLSchema + Const.callbackHost),
            scope: "notifications",
            state: "\(Date().timeIntervalSince1970)") { [weak self] (result: Result<OAuthSwift.TokenSuccess, OAuthSwiftError>) in
                self?.callback(result)
        }
    }
}
