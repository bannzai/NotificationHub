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
    struct Cell: RenderableView {
        @EnvironmentObject var store: Store<AppState>
        let watching: WatchingElement
        
        struct Props {
            let watching: WatchingElement
            let isReceiveNotification: Binding<Bool>
        }
        
        func map(state: AppState, dispatch: @escaping DispatchFunction) -> Props {
            Props(
                watching: watching,
                isReceiveNotification: Binding<Bool>(
                    get: { state.watchingListState.watchings.first(where: { $0.id == self.watching.id })!.isReceiveNotification },
                    set: { _ in self.store.dispatch(action: ToggleWatchingAction(watcihng: self.watching)) }
                )
            )
        }
        
        func body(props: Props) -> some View {
            HStack {
                ThumbnailImageView(url: props.watching.owner.avatarURL, defaultImage: UIImage(systemName: "person")!)
                Toggle(isOn: props.isReceiveNotification) { () in
                    Text(props.watching.owner.login).font(.headline).lineLimit(1)
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
