//
//  ViewExtension.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/06/19.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SwiftUI

extension View {
    func endEditing() {
        UIApplication.shared.keyWindow?.endEditing(true)
    }
}

