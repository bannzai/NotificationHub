//
//  NotificationListView.Cell.swift
//  NotificationHub
//
//  Created by Yudai.Hirose on 2019/06/07.
//  Copyright © 2019 bannzai. All rights reserved.
//

import SwiftUI
import Combine
import NotificationHubCore
import NotificationHubData
import NotificationHubRedux

extension NotificationListView {
    struct Cell: RenderableView {
        @EnvironmentObject var store: Store<AppState>
        
        let notification: NotificationElement
        let didSelectCell: (NotificationElement) -> Void
        
        struct Props {
            let notification: NotificationElement
        }
        
        func map(state: AppState, dispatch: @escaping DispatchFunction) -> Props {
            Props(
                notification: notification
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
                .gesture(cellGestuer)
            }
        }
    }
}

#if DEBUG
struct NotificationListView_Cell_Previews : PreviewProvider {
    static var previews: some View {
        List {
            NotificationListView.Cell(notification: debugNotification) { (element) in
                print(element)
            }
        }
    }
}
#endif
