//
//  WatchingListCell.swift
//  GitHubWatchingManager
//
//  Created by Yudai.Hirose on 2019/09/30.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SwiftUI
import Combine
import GitHubNotificationManagerNetwork

extension WatchingListView {
    struct Cell: View {
        var watching: WatchingEntity
        var body: some View {
            HStack {
                ThumbnailImageView(url: watching.owner.avatarURL, defaultImage: UIImage(systemName: "person")!)
                Toggle(isOn: watching.bindingReceiveNotification) { () in
                    Text(watching.owner.name).font(.headline).lineLimit(1)
                }
            }
        }
    }
}

#if DEBUG
//struct WatchingListView_Cell_Previews : PreviewProvider {
//    static var previews: some View {
//        WatchingListView.Cell(
//            watching: State(initialValue: WatchingEntity(
//                id: .init(id: 1),
//                name: "ABC",
//                owner: .init(name: "bannzai", avatarURL: Debug.Const.avatarURL),
//                notificationsURL: "https://api.github.com/repos/bannzai/vimrc/notifications{?since,all,participating}",
//                isReceiveNotification: false
//            )).projectedValue
//        )
//    }
//}
#endif
