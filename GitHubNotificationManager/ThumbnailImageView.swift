//
//  ImageLoaderView.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/06/07.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SwiftUI
import GitHubNotificationManagerNetwork

fileprivate typealias Container = VStack // FIXME: Group can not call onAppear
struct ThumbnailImageView : View {
    @State var viewModel = ImageLoaderViewModel()
    let url: URLConvertible
    var body: some View {
        Container {
            if self.viewModel.image != nil {
                Image(uiImage: self.viewModel.image!)
            } else {
                EmptyView()
            }
        }
            .onAppear {
                self.viewModel.load(url: self.url)
        }
        .frame(width: 100, height: 100, alignment: .center)
    }
}

#if DEBUG
struct ThumbnailImageView_Previews : PreviewProvider {
    static var previews: some View {
        ThumbnailImageView(url: "https://avatars0.githubusercontent.com/u/10897361?s=460&v=4")
    }
}
#endif
