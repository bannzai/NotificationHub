//
//  WatchingListCell.swift
//  GitHubWatchingManager
//
//  Created by Yudai.Hirose on 2019/09/30.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SwiftUI
import Combine

extension WatchingListView {
    struct Cell: View {
        let watching: WatchingModel
        var body: some View {
            HStack {
                ThumbnailImageView(url: repository.avatarURL)
                VStack(alignment: .leading) {
                    Text(repository.fullName).font(.headline).lineLimit(1)
                    Text(subject.title).font(.subheadline).lineLimit(1)
                }
            }
        }
    }
}

#if DEBUG
struct WatchingListView_Cell_Previews : PreviewProvider {
    static var previews: some View {
        WatchingListView.Cell(
            Watching: debugWatching
        )
    }
}
#endif
