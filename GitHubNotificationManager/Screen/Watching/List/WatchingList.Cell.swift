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
        
        // Dummy Value for animated toggle
        class DummyValue {
            var toggleValue: Bool = false
        }
        let dummy = DummyValue()

        struct Props {
            let watching: WatchingElement
            let isReceiveNotification: Binding<Bool>
        }
        
        func map(state: AppState, dispatch: @escaping DispatchFunction) -> Props {
            dummy.toggleValue = state.watchingListState.watchings.first(where: { $0.owner.login == self.watching.owner.login })!.isReceiveNotification
            return Props(
                watching: watching,
                isReceiveNotification: Binding<Bool>(
                    get: { self.dummy.toggleValue },
                    set: { value in
                        self.dummy.toggleValue = value
                        dispatch(action: CreateNotificationsAction(watching: self.watching))
                        dispatch(action: ToggleWatchingAction(watcihng: self.watching))
                })
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
