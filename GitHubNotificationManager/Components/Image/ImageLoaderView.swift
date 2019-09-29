//
//  ImageLoaderView.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/06/07.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SwiftUI
import GitHubNotificationManagerNetwork

fileprivate typealias Container = VStack // FIXME: Group does not call onAppear
struct ImageLoaderView : View {
    @ObservedObject var viewModel = ImageLoaderViewModel()
    
    let url: URLConvertible
    var body: some View {
        Container {
            Image(uiImage: viewModel.image)
        }
        .onAppear {
            self.viewModel.load(url: self.url)
        }
    }
}

#if DEBUG
struct ImageLoaderView_Previews : PreviewProvider {
    static var previews: some View {
        ImageLoaderView(url: Debug.Const.avatarURL)
    }
}
#endif
