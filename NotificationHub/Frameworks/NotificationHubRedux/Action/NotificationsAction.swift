//
//  NotificationsAction.swift
//  NotificationHub
//
//  Created by Yudai Hirose on 2019/10/13.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation
import NotificationHubCore
import Combine

public struct CreateNotificationsAction: Action {
    let watching: WatchingElement
}
public struct AddNotificationListAction: Action {
    let watching: WatchingElement?
    let elements: [NotificationElement]
}

public struct ChangeNotificationPageAction: Action {
    let page: Int
    public init(page: Int) {
        self.page = page
    }
}


public struct UpdateNotificationsTorRead: Action {
    let watching: WatchingElement?
    let sectionDate: String
}

public struct ReadNotificationAction: AsyncAction, ReadNotificationPath {
    let watching: WatchingElement?
    let sectionDate: String
    var canceller: Canceller
    
    init(
        watching: WatchingElement?,
        sectionDate: String,
        canceller: Canceller
    ) {
        self.watching = watching
        self.sectionDate = sectionDate
        self.canceller = canceller
    }

    public var readNotificationPath: URLPathConvertible {
        switch watching {
        case nil:
            return "notifications"
        case let watching?:
            // e.g) https://api.github.com/repos/bannzai/vimrc/notifications{?since,all,participating}
            // Drop {?since, all, participating}
            return watching.notificationsUrl
                .split(separator: "/")
                .reduce(into: "") { (result, element) in
                    switch element {
                    case "/":
                        return
                    case "https:", "api.github.com":
                        return
                    case _:
                        break
                    }
                    
                    switch element.contains("{") {
                    case false:
                        // repos bannzai vimrc
                        result += element + "/"
                    case true:
                        result += element.split(separator: "{").dropLast().joined()
                    }
            }
        }
    }

    public func async(state: ReduxState?, dispatch: @escaping DispatchFunction) {
        let oneDay = TimeInterval(60 * 60 * 24)
        var date = SectionTitleDateFormatter.date(from: sectionDate)
        date.addTimeInterval(oneDay)
        let lastReadAt = APIDateformatter.string(from: date)

        dispatch(NetworkRequestAction.start)
        GitHubAPI
            .request(request: ReadNotificationsRequest(lastReadAt: lastReadAt, notificationsUrl: self))
            .map({ UpdateNotificationsTorRead(watching: self.watching, sectionDate: self.sectionDate) })
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    dispatch(ReceiveNetworkRequestError.init(error: error))
                }
                dispatch(NetworkRequestAction.finished)
            }, receiveValue: { values in
                dispatch(values)
            })
            .store(in: &canceller.canceller)
    }
}

public struct NotificationsFetchAction: AsyncAction {
    let watching: WatchingElement?
    var canceller: Canceller
    
    public init(
        watching: WatchingElement?,
        canceller: Canceller
    ) {
        self.watching = watching
        self.canceller = canceller
    }

    public func async(state: ReduxState?, dispatch: @escaping DispatchFunction) {
        let state = appState(state).notificationPageState.notificationsStatuses.first(where: { $0.watching?.owner.login == watching?.owner.login })!
        let mapper: ([NotificationElement]) -> AddNotificationListAction = {
            AddNotificationListAction(watching: self.watching, elements: $0)
        }
        
        dispatch(NetworkRequestAction.start)
        GitHubAPI
            .request(request: NotificationsRequest(page: state.nextFetchPage, notificationsUrl: state))
            .map(mapper)
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    dispatch(ReceiveNetworkRequestError.init(error: error))
                }
                dispatch(NetworkRequestAction.finished)
            }, receiveValue: { values in
                dispatch(values)
            })
            .store(in: &canceller.canceller)
    }
}
