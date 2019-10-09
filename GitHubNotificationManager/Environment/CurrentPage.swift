//
//  CurrentPage.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/10/09.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation
import SwiftUI

struct CurrentPageKey: EnvironmentKey {
    static var defaultValue: Int = 0
}

extension EnvironmentValues {
    var currentPage: Int {
        get { self[CurrentPageKey.self] }
        set { self[CurrentPageKey.self] = newValue }
    }
}
