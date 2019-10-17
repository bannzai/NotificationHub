//
//  NotificationListView.Section.swift
//  NotificationHub
//
//  Created by Yudai Hirose on 2019/10/15.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SwiftUI
import NotificationHubNetwork

extension NotificationListView {
    struct SectionView: RenderableView {
        @EnvironmentObject var store: Store<AppState>

        let groupedNotification: GroupedNotification
        let watching: WatchingElement?
        let unreadButtonPressed: (GroupedNotification) -> Void
        
        struct Props {
            let title: String
            let groupedNotification: GroupedNotification
            let unreadButtonPressed: (GroupedNotification) -> Void
        }

        func map(state: AppState, dispatch: @escaping DispatchFunction) -> Props {
            Props(
                title: groupedNotification.key,
                groupedNotification: groupedNotification,
                unreadButtonPressed: unreadButtonPressed
            )
        }
        
        func body(props: Props) -> some View {
            HStack {
                Text(props.title)
                Spacer()
                ReadButton {
                    props.unreadButtonPressed(props.groupedNotification)
                }
            }
        }
    }
}

struct NotificationListView_Section_Previews: PreviewProvider {
    static var previews: some View {
        NotificationListView.SectionView(
            groupedNotification: GroupedNotification(
                key: "2019-10-15",
                values: []
            ),
            watching: nil,
            unreadButtonPressed: { print($0) }
        )
    }
}
