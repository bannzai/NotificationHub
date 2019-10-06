//
//  ThumbnailImageViewModifier.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/10/06.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SwiftUI

struct ThumbnailImageViewModifier: ViewModifier {
    let edge: CGFloat = 44
    
    func body(content: Content) -> some View {
        content
            .frame(width: edge, height: edge, alignment: .center)
            .aspectRatio(contentMode: .fit)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.gray, lineWidth: 1))
    }
}
