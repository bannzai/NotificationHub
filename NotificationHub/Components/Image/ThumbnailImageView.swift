//
//  ThumbnailImageViewModifier.swift
//  NotificationHub
//
//  Created by Yudai.Hirose on 2019/10/06.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SwiftUI
import NotificationHubCore

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

struct ThumbnailImageView: View {
    let url: URLConvertible
    let defaultImage: UIImage
    let edge: CGFloat = 44
    
    var body: some View {
        ImageLoaderView(url: url, defaultImage: defaultImage)
            .modifier(ThumbnailImageViewModifier())
    }
}

#if DEBUG
struct ThumbnailImageView_Previews : PreviewProvider {
    static var previews: some View {
        ThumbnailImageView(url: Debug.Const.avatarURL, defaultImage: UIImage(systemName: "person")!)
    }
}
#endif
