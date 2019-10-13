// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let notification = try? newJSONDecoder().decode(Notification.self, from: jsonData)

import Foundation
import GitHubNotificationManagerCore

// MARK: - NotificationElement
public struct NotificationElement: Codable, Identifiable {
    public let id: String
    public let unread: Bool
    public let subject: Subject
    public let repository: Repository
    public let reason: String
    public let url: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case unread
        case subject
        case repository
        case reason
        case url
    }
    
    public init(
        id: String,
        unread: Bool,
        subject: Subject,
        repository: Repository,
        reason: String,
        url: String
    ) {
        self.id = id
        self.unread = unread
        self.subject = subject
        self.repository = repository
        self.reason = reason
        self.url = url
    }
}

// MARK: - Repository
public struct Repository: Codable {
    public let id: Int
    public let name: String
    public let fullName: String
    public let repositoryPrivate: Bool
    public let owner: Owner

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case repositoryPrivate = "private"
        case owner
    }
    
    public init(
        id: Int,
        name: String,
        fullName: String,
        repositoryPrivate: Bool,
        owner: Owner
    ) {
        self.id = id
        self.name = name
        self.fullName = fullName
        self.repositoryPrivate = repositoryPrivate
        self.owner = owner
    }
}

// MARK: - Owner
public struct Owner: Codable {
    public let id: Int
    public let login: String
    public let avatarURL: String

    enum CodingKeys: String, CodingKey {
        case id
        case login
        case avatarURL = "avatar_url"
    }
    
    public init( id: Int, login: String, avatarURL: String) {
        self.id = id
        self.login = login
        self.avatarURL = avatarURL
    }
}

// MARK: - Subject
public struct Subject: Codable {
    public let title: String
    public let url: String

    enum CodingKeys: String, CodingKey {
        case title
        case url
    }
    
    public init(title: String, url: String) {
        self.title = title
        self.url = url
    }
}
