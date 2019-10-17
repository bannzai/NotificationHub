//
//  AppState.swift
//  GitHubNotificationManager
//
//  Created by Yudai Hirose on 2019/10/13.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation
import GitHubNotificationManagerNetwork

struct Coder<Coder: Codable> {
    private let key = Coder.self
    
    private var url: URL {
        let url = FileManager.default.urls(
            for: .cachesDirectory,
            in: .userDomainMask
        ).first!
        let dataUrl = url.appendingPathComponent("\(type(of: key)).json")
        return dataUrl
    }
    
    func write(for coder: Coder) throws {
        let data = try JSONEncoder().encode(coder)
        try data.write(to: url)
    }
    
    func read() throws -> Coder? {
        let data = try Data(contentsOf: url)
        let decoded = try JSONDecoder().decode(Coder.self, from: data)
        return decoded
    }
}

public struct AppState: ReduxState, Codable, Equatable {
    public init() { }
    var requestError: RequestError? = nil
    var watchingListState = WatchingsState()
    var hudState: HUDState = HUDState()
    var notificationPageState: NotificationPageState = NotificationPageState()
    var authentificationState: AuthenfiicationState = AuthenfiicationState()
    var title: String { notificationPageState.currentState.watching?.owner.login ?? "Notifications" }

    private enum CodingKeys: String, CodingKey {
        case watchingListState
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(watchingListState, forKey: .watchingListState)
    }
}
