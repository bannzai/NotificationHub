// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let notification = try? newJSONDecoder().decode(Notification.self, from: jsonData)

import Foundation
import NotificationHubCore

// MARK: - NotificationElement
public struct NotificationElement: Codable, Identifiable, Equatable {
    public let id: String
    public var unread: Bool
    public let subject: Subject
    public let repository: Repository
    public let reason: String
    public let url: String
    public let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case unread
        case subject
        case repository
        case reason
        case url
        case updatedAt = "updated_at"
    }
    
    public init(
        id: String,
        unread: Bool,
        subject: Subject,
        repository: Repository,
        reason: String,
        url: String,
        updatedAt: String
    ) {
        self.id = id
        self.unread = unread
        self.subject = subject
        self.repository = repository
        self.reason = reason
        self.url = url
        self.updatedAt = updatedAt
    }
}

// MARK: - Repository
public struct Repository: Codable, Equatable {
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
public struct Owner: Codable, Equatable {
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
public struct Subject: Codable, Equatable {
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

