//
//  Notification.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/06/19.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation
import SwiftUI
import GitHubNotificationManagerNetwork

struct NotificationModel: Identifiable {
    struct Repository {
        let id: Int
        let name: String
        let ownerName: String
        let avatarURL: String
        let fullName: String
    }
    struct Subject {
        let title: String
        let url: String
        // FIXME: from https://api.github.com/repos/{Owner}/{RepoName}/pulls/{Number}
        var destinationURL: URL {
            guard let components = URLComponents(string: url) else {
                fatalError("Missing format url from API")
            }
            
            let path = components
                .path
                .components(separatedBy: "/")
                .filter { !$0.isEmpty }
                .enumerated()
                .reduce("/") { (result, elements) in
                    let isReposPath = elements.offset == 0
                    if isReposPath {
                        return result
                    }
                    let isPulls = elements.offset == 3
                    if isPulls {
                        return result + "/" + "pull"
                    }
                    return result + "/" + elements.element
            }
            return URL(string: "https://github.com" + path)!
        }
    }
    let id: String
    let reason: String
    let repository: Repository
    let subject: Subject
    let url: String
    var unread: Bool
    
    static func create(entity: NotificationElement) -> NotificationModel {
        NotificationModel(
            id: entity.id,
            reason: entity.reason,
            repository: NotificationModel.Repository(
                id: entity.repository.id,
                name: entity.repository.name,
                ownerName: entity.repository.owner.login,
                avatarURL: entity.repository.owner.avatarURL,
                fullName: entity.repository.fullName
            ),
            subject: NotificationModel.Subject(
                title: entity.subject.title,
                url: entity.subject.url
            ),
            url: entity.url,
            unread: entity.unread
        )
    }
}

extension NotificationModel: FuzzyFindable {
    func fuzzyWords() -> [String] {
        [
            repository.name,
            repository.ownerName,
            repository.avatarURL,
            repository.fullName,
            reason,
            url,
            subject.title,
            subject.url
        ]
    }
}
