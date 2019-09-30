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
                ThumbnailImageView(url: watching.owner.avatarURL)
                VStack(alignment: .leading) {
                    Text(watching.owner.name).font(.headline).lineLimit(1)
                }
            }
        }
    }
}

#if DEBUG
struct WatchingListView_Cell_Previews : PreviewProvider {
    static var previews: some View {
        WatchingListView.Cell(
            watching: WatchingModel(
                id: 1,
                owner: .init(name: "bannzai", avatarURL: Debug.Const.avatarURL)
            )
        )
    }
}
#endif
