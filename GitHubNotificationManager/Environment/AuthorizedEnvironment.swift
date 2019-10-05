//
//  AuthorizedEnvironment.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/10/04.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation
import SwiftUI

struct AuthorizedEnvironmentKey: EnvironmentKey {
    static var defaultValue: Bool = false
}

extension EnvironmentValues {
    var isAuthorized: Bool {
        get { self[AuthorizedEnvironmentKey.self] }
        set { self[AuthorizedEnvironmentKey.self] = newValue }
    }
}
