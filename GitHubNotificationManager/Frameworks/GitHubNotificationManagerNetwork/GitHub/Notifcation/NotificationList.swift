// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let notification = try? newJSONDecoder().decode(Notification.self, from: jsonData)

import Foundation

// MARK: - NotificationElement
public struct NotificationElement: Codable {
    public let id: String
    public let unread: Bool
    public let reason, updatedAt: String
    public let lastReadAt: String?
    public let subject: Subject
    public let repository: Repository
    public let url, subscriptionURL: String
    
    enum CodingKeys: String, CodingKey {
        case id, unread, reason
        case updatedAt = "updated_at"
        case lastReadAt = "last_read_at"
        case subject, repository, url
        case subscriptionURL = "subscription_url"
    }
    
    public init(id: String, unread: Bool, reason: String, updatedAt: String, lastReadAt: String?, subject: Subject, repository: Repository, url: String, subscriptionURL: String) {
        self.id = id
        self.unread = unread
        self.reason = reason
        self.updatedAt = updatedAt
        self.lastReadAt = lastReadAt
        self.subject = subject
        self.repository = repository
        self.url = url
        self.subscriptionURL = subscriptionURL
    }
}

// MARK: - Repository
public struct Repository: Codable {
    public let id: Int
    public let nodeID, name, fullName: String
    public let repositoryPrivate: Bool
    public let owner: Owner
    public let htmlURL: String
    public let repositoryDescription: String?
    public let fork: Bool
    public let url, forksURL: String
    public let keysURL, collaboratorsURL: String
    public let teamsURL, hooksURL: String
    public let issueEventsURL: String
    public let eventsURL: String
    public let assigneesURL, branchesURL: String
    public let tagsURL: String
    public let blobsURL, gitTagsURL, gitRefsURL, treesURL: String
    public let statusesURL: String
    public let languagesURL, stargazersURL, contributorsURL, subscribersURL: String
    public let subscriptionURL: String
    public let commitsURL, gitCommitsURL, commentsURL, issueCommentURL: String
    public let contentsURL, compareURL: String
    public let mergesURL: String
    public let archiveURL: String
    public let downloadsURL: String
    public let issuesURL, pullsURL, milestonesURL, notificationsURL: String
    public let labelsURL, releasesURL: String
    public let deploymentsURL: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case nodeID = "node_id"
        case name
        case fullName = "full_name"
        case repositoryPrivate = "private"
        case owner
        case htmlURL = "html_url"
        case repositoryDescription = "description"
        case fork, url
        case forksURL = "forks_url"
        case keysURL = "keys_url"
        case collaboratorsURL = "collaborators_url"
        case teamsURL = "teams_url"
        case hooksURL = "hooks_url"
        case issueEventsURL = "issue_events_url"
        case eventsURL = "events_url"
        case assigneesURL = "assignees_url"
        case branchesURL = "branches_url"
        case tagsURL = "tags_url"
        case blobsURL = "blobs_url"
        case gitTagsURL = "git_tags_url"
        case gitRefsURL = "git_refs_url"
        case treesURL = "trees_url"
        case statusesURL = "statuses_url"
        case languagesURL = "languages_url"
        case stargazersURL = "stargazers_url"
        case contributorsURL = "contributors_url"
        case subscribersURL = "subscribers_url"
        case subscriptionURL = "subscription_url"
        case commitsURL = "commits_url"
        case gitCommitsURL = "git_commits_url"
        case commentsURL = "comments_url"
        case issueCommentURL = "issue_comment_url"
        case contentsURL = "contents_url"
        case compareURL = "compare_url"
        case mergesURL = "merges_url"
        case archiveURL = "archive_url"
        case downloadsURL = "downloads_url"
        case issuesURL = "issues_url"
        case pullsURL = "pulls_url"
        case milestonesURL = "milestones_url"
        case notificationsURL = "notifications_url"
        case labelsURL = "labels_url"
        case releasesURL = "releases_url"
        case deploymentsURL = "deployments_url"
    }
    
    public init(id: Int, nodeID: String, name: String, fullName: String, repositoryPrivate: Bool, owner: Owner, htmlURL: String, repositoryDescription: String?, fork: Bool, url: String, forksURL: String, keysURL: String, collaboratorsURL: String, teamsURL: String, hooksURL: String, issueEventsURL: String, eventsURL: String, assigneesURL: String, branchesURL: String, tagsURL: String, blobsURL: String, gitTagsURL: String, gitRefsURL: String, treesURL: String, statusesURL: String, languagesURL: String, stargazersURL: String, contributorsURL: String, subscribersURL: String, subscriptionURL: String, commitsURL: String, gitCommitsURL: String, commentsURL: String, issueCommentURL: String, contentsURL: String, compareURL: String, mergesURL: String, archiveURL: String, downloadsURL: String, issuesURL: String, pullsURL: String, milestonesURL: String, notificationsURL: String, labelsURL: String, releasesURL: String, deploymentsURL: String) {
        self.id = id
        self.nodeID = nodeID
        self.name = name
        self.fullName = fullName
        self.repositoryPrivate = repositoryPrivate
        self.owner = owner
        self.htmlURL = htmlURL
        self.repositoryDescription = repositoryDescription
        self.fork = fork
        self.url = url
        self.forksURL = forksURL
        self.keysURL = keysURL
        self.collaboratorsURL = collaboratorsURL
        self.teamsURL = teamsURL
        self.hooksURL = hooksURL
        self.issueEventsURL = issueEventsURL
        self.eventsURL = eventsURL
        self.assigneesURL = assigneesURL
        self.branchesURL = branchesURL
        self.tagsURL = tagsURL
        self.blobsURL = blobsURL
        self.gitTagsURL = gitTagsURL
        self.gitRefsURL = gitRefsURL
        self.treesURL = treesURL
        self.statusesURL = statusesURL
        self.languagesURL = languagesURL
        self.stargazersURL = stargazersURL
        self.contributorsURL = contributorsURL
        self.subscribersURL = subscribersURL
        self.subscriptionURL = subscriptionURL
        self.commitsURL = commitsURL
        self.gitCommitsURL = gitCommitsURL
        self.commentsURL = commentsURL
        self.issueCommentURL = issueCommentURL
        self.contentsURL = contentsURL
        self.compareURL = compareURL
        self.mergesURL = mergesURL
        self.archiveURL = archiveURL
        self.downloadsURL = downloadsURL
        self.issuesURL = issuesURL
        self.pullsURL = pullsURL
        self.milestonesURL = milestonesURL
        self.notificationsURL = notificationsURL
        self.labelsURL = labelsURL
        self.releasesURL = releasesURL
        self.deploymentsURL = deploymentsURL
    }
}

// MARK: - Owner
public struct Owner: Codable {
    public let login: String
    public let id: Int
    public let nodeID: String
    public let avatarURL: String
    public let gravatarID: String
    public let url, htmlURL, followersURL: String
    public let followingURL, gistsURL, starredURL: String
    public let subscriptionsURL, organizationsURL, reposURL: String
    public let eventsURL: String
    public let receivedEventsURL: String
    public let type: String
    public let siteAdmin: Bool
    
    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case type
        case siteAdmin = "site_admin"
    }
    
    public init(login: String, id: Int, nodeID: String, avatarURL: String, gravatarID: String, url: String, htmlURL: String, followersURL: String, followingURL: String, gistsURL: String, starredURL: String, subscriptionsURL: String, organizationsURL: String, reposURL: String, eventsURL: String, receivedEventsURL: String, type: String, siteAdmin: Bool) {
        self.login = login
        self.id = id
        self.nodeID = nodeID
        self.avatarURL = avatarURL
        self.gravatarID = gravatarID
        self.url = url
        self.htmlURL = htmlURL
        self.followersURL = followersURL
        self.followingURL = followingURL
        self.gistsURL = gistsURL
        self.starredURL = starredURL
        self.subscriptionsURL = subscriptionsURL
        self.organizationsURL = organizationsURL
        self.reposURL = reposURL
        self.eventsURL = eventsURL
        self.receivedEventsURL = receivedEventsURL
        self.type = type
        self.siteAdmin = siteAdmin
    }
}

// MARK: - Subject
public struct Subject: Codable {
    public let title: String
    public let url: String
    public let latestCommentURL: String?
    public let type: String
    
    enum CodingKeys: String, CodingKey {
        case title, url
        case latestCommentURL = "latest_comment_url"
        case type
    }
    
    public init(title: String, url: String, latestCommentURL: String?, type: String) {
        self.title = title
        self.url = url
        self.latestCommentURL = latestCommentURL
        self.type = type
    }
}

public typealias Notification = [NotificationElement]
