//
//  ImageLoaderView.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/06/07.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SwiftUI
import GitHubNotificationManagerNetwork

struct ImageLoaderView : View {
    @ObservedObject var viewModel = ImageLoaderViewModel()
    
    let url: URLConvertible
    var body: some View {
        Image(uiImage: viewModel.image)
            .resizable()
            .renderingMode(.original)
            .onAppear {
                self.viewModel.load(url: self.url)
        }
    }
}

#if DEBUG
struct ImageLoaderView_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            ImageLoaderView(url: Debug.Const.avatarURL)
                .modifier(ThumbnailImageViewModifier())
        }
    }
}
#endif
