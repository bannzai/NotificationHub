//
//  ThumbnailImageView.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/06/07.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SwiftUI

struct ThumbnailImageView : View {
    var image: ImageLoaderView
    let edge: CGFloat = 44
    var body: some View {
        image
            .frame(width: edge, height: edge, alignment: .center)
            .aspectRatio(contentMode: .fit)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.gray, lineWidth: 1))
    }
}

#if DEBUG
struct CircleImageView_Previews : PreviewProvider {
    static var previews: some View {
        ThumbnailImageView(image: ImageLoaderView(url: Debug.Const.avatarURL))
    }
}
#endif
