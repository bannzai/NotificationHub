//
//  NotificationsAction.swift
//  NotificationHub
//
//  Created by Yudai Hirose on 2019/10/13.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation
import NotificationHubCore
import NotificationHubData
import Combine

public struct CreateNotificationsAction: Action {
    let watching: WatchingElement

// sourcery:inline:auto:CreateNotificationsAction.AutoInitAction:
    public init(
        watching: WatchingElement
        ) {
        self.watching = watching
    }
// sourcery:end
}
public struct AddNotificationListAction: Action {
    let watching: WatchingElement?
    let elements: [NotificationElement]

// sourcery:inline:auto:AddNotificationListAction.AutoInitAction:
    public init(
        watching: WatchingElement?,
        elements: [NotificationElement]
        ) {
        self.watching = watching
        self.elements = elements
    }
// sourcery:end
}

public struct ChangeNotificationPageAction: Action {
    let page: Int
// sourcery:inline:auto:ChangeNotificationPageAction.AutoInitAction:
    public init(
        page: Int
        ) {
        self.page = page
    }
// sourcery:end
}


public struct UpdateNotificationsTorRead: Action {
    let watching: WatchingElement?
    let sectionDate: String

// sourcery:inline:auto:UpdateNotificationsTorRead.AutoInitAction:
    public init(
        watching: WatchingElement?,
        sectionDate: String
        ) {
        self.watching = watching
        self.sectionDate = sectionDate
    }
// sourcery:end
}

public struct ReadNotificationAction: AsyncAction, ReadNotificationPath {
    let watching: WatchingElement?
    let sectionDate: String
    var canceller: Canceller

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

// sourcery:inline:auto:ReadNotificationAction.AutoInitAction:
    public init(
        watching: WatchingElement?,
        sectionDate: String,
        canceller: Canceller
        ) {
        self.watching = watching
        self.sectionDate = sectionDate
        self.canceller = canceller
    }
// sourcery:end
}

public struct NotificationsFetchAction: AsyncAction {
    let watching: WatchingElement?
    var canceller: Canceller
    
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

// sourcery:inline:auto:NotificationsFetchAction.AutoInitAction:
    public init(
        watching: WatchingElement?,
        canceller: Canceller
        ) {
        self.watching = watching
        self.canceller = canceller
    }
// sourcery:end
}
