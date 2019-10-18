//
//  ImageLoaderView.swift
//  NotificationHub
//
//  Created by Yudai.Hirose on 2019/06/07.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SwiftUI
import NotificationHubCore

struct ImageLoaderView : View {
    @ObservedObject var viewModel = ImageLoaderViewModel()
    @State private var loadedImage: UIImage?
    
    var image: UIImage {
        loadedImage ?? defaultImage
    }

    let url: URLConvertible
    let defaultImage: UIImage
    init(url: URLConvertible, defaultImage: UIImage) {
        self.url = url
        self.defaultImage = defaultImage
    }
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .renderingMode(.original)
            .onAppear {
                self.viewModel.load(url: self.url) {
                    self.loadedImage = $0
                }
        }
    }
}

struct ImageLoaderView_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            ImageLoaderView(url: Debug.Const.avatarURL, defaultImage: UIImage(systemName: "person")!)
                .modifier(ThumbnailImageViewModifier())
        }
    }
}
