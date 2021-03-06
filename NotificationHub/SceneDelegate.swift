//
//  SceneDelegate.swift
//  NotificationHub
//
//  Created by Yudai.Hirose on 2019/06/05.
//  Copyright © 2019 bannzai. All rights reserved.
//

import UIKit
import SwiftUI
import OAuthSwift
import NotificationHubCore
import CoreData
import NotificationHubRedux

let sharedStore = Store<AppState>(
    reducer: appReducer,
    middlewares: [
        loggingMiddleware,
        asyncActionsMiddleware,
        signupMiddleware,
    ],
    initialState: AppState()
)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var saveStatTimer: Timer?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        // Use a UIHostingController as window root view controller
        #if DEBUG
//        UserDefaults.standard.set(Secret.Debug.accessToken, forKey: .GitHubAccessToken)
        #endif
        sharedStore.restore()
        if let token = UserDefaults.standard.string(forKey: .GitHubAccessToken) {
            sharedStore.dispatch(action: SignupAction(githubAccessToken: token))
        }
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(
                rootView: StoreProvider(store: sharedStore, content: {
                    RootView()
                })
            )
            self.window = window
            window.makeKeyAndVisible()
        }
        
        saveStatTimer = Timer.scheduledTimer(withTimeInterval: 30.0, repeats: true, block: { _ in
            sharedStore.saveState()
        })
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        sharedStore.saveState()
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        URLContexts.first.map { context in
            if (context.url.host == "oauth-callback") {
                OAuthSwift.handle(url: context.url)
            }
        }
    }
}

