//
//  NotificationListView.Cell.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/06/07.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SwiftUI
import Combine
import GitHubNotificationManagerNetwork

extension NotificationListView {
    struct Cell: RenderableView {
        @EnvironmentObject var store: Store<AppState>
        
        let notification: NotificationElement
        let didSelectCell: (NotificationElement) -> Void
        
        struct Props {
            let notification: NotificationElement
            let unreadBinding: Binding<Bool>
        }
        
        func map(state: AppState, dispatch: @escaping DispatchFunction) -> Props {
            Props(
                notification: notification,
                unreadBinding: Binding<Bool>(
                    get: { self.notification.unread },
                    set: { self.store.dispatch(action: UnReadNotificationAction(notification: self.notification, unread: $0)) }
                )
            )
        }
        
        var cellGestuer: some Gesture {
            TapGesture().onEnded {
                self.didSelectCell(self.notification)
            }
        }
        
        func body(props: Props) -> some View {
            HStack {
                Group {
                    ImageLoaderView(url: props.notification.repository.owner.avatarURL, defaultImage: UIImage(systemName: "person")!)
                        .modifier(ThumbnailImageViewModifier())
                    VStack(alignment: .leading) {
                        Text(props.notification.repository.fullName).font(.headline).lineLimit(1)
                        Text(props.notification.subject.title).font(.subheadline).lineLimit(1)
                    }
                }
                .layoutPriority(DefaultLayoutPriority + 1)
                .gesture(cellGestuer)
                Spacer()
                ReadButton(read: props.unreadBinding)
            }
        }
    }
}

// TODO:
//#if DEBUG
//struct NotificationListView_Cell_Previews : PreviewProvider {
//    static var previews: some View {
//        fatalError("TODO:")
//    }
//}
//#endif
