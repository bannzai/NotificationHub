//
//  ViewExtension.swift
//  NotificationHub
//
//  Created by Yudai.Hirose on 2019/06/19.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SwiftUI

extension View {
    func endEditing() {
        UIApplication.shared.connectedScenes
            .compactMap {$0 as? UIWindowScene}
            .first { $0.activationState == .foregroundActive }?
            .windows
            .first {$0.isKeyWindow}?
            .endEditing(true)
    }
}
