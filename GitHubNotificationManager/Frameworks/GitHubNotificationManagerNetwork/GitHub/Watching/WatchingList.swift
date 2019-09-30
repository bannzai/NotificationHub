// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let watchingElements = try? newJSONDecoder().decode(WatchingElements.self, from: jsonData)

import Foundation

// MARK: - WatchingElement
public struct WatchingElement: Codable {
    public let id: Int
    public let nodeID, name, fullName: String
    public let owner: Owner
    public let watchingElementPrivate: Bool
    public let htmlURL: String
    public let watchingElementDescription: String
    public let fork: Bool
    public let url: String
    public let archiveURL, assigneesURL, blobsURL, branchesURL: String
    public let collaboratorsURL, commentsURL, commitsURL, compareURL: String
    public let contentsURL: String
    public let contributorsURL, deploymentsURL, downloadsURL, eventsURL: String
    public let forksURL: String
    public let gitCommitsURL, gitRefsURL, gitTagsURL, gitURL: String
    public let issueCommentURL, issueEventsURL, issuesURL, keysURL: String
    public let labelsURL: String
    public let languagesURL, mergesURL: String
    public let milestonesURL, notificationsURL, pullsURL, releasesURL: String
    public let sshURL: String
    public let stargazersURL: String
    public let statusesURL: String
    public let subscribersURL, subscriptionURL, tagsURL, teamsURL: String
    public let treesURL: String
    public let cloneURL: String
    public let mirrorURL: String
    public let hooksURL: String
    public let svnURL, homepage: String
    public let language: JSONNull?
    public let forksCount, stargazersCount, watchersCount, size: Int
    public let defaultBranch: String
    public let openIssuesCount: Int
    public let isTemplate: Bool
    public let topics: [String]
    public let hasIssues, hasProjects, hasWiki, hasPages: Bool
    public let hasDownloads, archived, disabled: Bool
    public let pushedAt, createdAt, updatedAt: String
    public let permissions: Permissions
    public let templateRepository: JSONNull?
    public let subscribersCount, networkCount: Int
    public let license: License

    enum CodingKeys: String, CodingKey {
        case id
        case nodeID = "node_id"
        case name
        case fullName = "full_name"
        case owner
        case watchingElementPrivate = "private"
        case htmlURL = "html_url"
        case watchingElementDescription = "description"
        case fork, url
        case archiveURL = "archive_url"
        case assigneesURL = "assignees_url"
        case blobsURL = "blobs_url"
        case branchesURL = "branches_url"
        case collaboratorsURL = "collaborators_url"
        case commentsURL = "comments_url"
        case commitsURL = "commits_url"
        case compareURL = "compare_url"
        case contentsURL = "contents_url"
        case contributorsURL = "contributors_url"
        case deploymentsURL = "deployments_url"
        case downloadsURL = "downloads_url"
        case eventsURL = "events_url"
        case forksURL = "forks_url"
        case gitCommitsURL = "git_commits_url"
        case gitRefsURL = "git_refs_url"
        case gitTagsURL = "git_tags_url"
        case gitURL = "git_url"
        case issueCommentURL = "issue_comment_url"
        case issueEventsURL = "issue_events_url"
        case issuesURL = "issues_url"
        case keysURL = "keys_url"
        case labelsURL = "labels_url"
        case languagesURL = "languages_url"
        case mergesURL = "merges_url"
        case milestonesURL = "milestones_url"
        case notificationsURL = "notifications_url"
        case pullsURL = "pulls_url"
        case releasesURL = "releases_url"
        case sshURL = "ssh_url"
        case stargazersURL = "stargazers_url"
        case statusesURL = "statuses_url"
        case subscribersURL = "subscribers_url"
        case subscriptionURL = "subscription_url"
        case tagsURL = "tags_url"
        case teamsURL = "teams_url"
        case treesURL = "trees_url"
        case cloneURL = "clone_url"
        case mirrorURL = "mirror_url"
        case hooksURL = "hooks_url"
        case svnURL = "svn_url"
        case homepage, language
        case forksCount = "forks_count"
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case size
        case defaultBranch = "default_branch"
        case openIssuesCount = "open_issues_count"
        case isTemplate = "is_template"
        case topics
        case hasIssues = "has_issues"
        case hasProjects = "has_projects"
        case hasWiki = "has_wiki"
        case hasPages = "has_pages"
        case hasDownloads = "has_downloads"
        case archived, disabled
        case pushedAt = "pushed_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case permissions
        case templateRepository = "template_repository"
        case subscribersCount = "subscribers_count"
        case networkCount = "network_count"
        case license
    }

    public init(id: Int, nodeID: String, name: String, fullName: String, owner: Owner, watchingElementPrivate: Bool, htmlURL: String, watchingElementDescription: String, fork: Bool, url: String, archiveURL: String, assigneesURL: String, blobsURL: String, branchesURL: String, collaboratorsURL: String, commentsURL: String, commitsURL: String, compareURL: String, contentsURL: String, contributorsURL: String, deploymentsURL: String, downloadsURL: String, eventsURL: String, forksURL: String, gitCommitsURL: String, gitRefsURL: String, gitTagsURL: String, gitURL: String, issueCommentURL: String, issueEventsURL: String, issuesURL: String, keysURL: String, labelsURL: String, languagesURL: String, mergesURL: String, milestonesURL: String, notificationsURL: String, pullsURL: String, releasesURL: String, sshURL: String, stargazersURL: String, statusesURL: String, subscribersURL: String, subscriptionURL: String, tagsURL: String, teamsURL: String, treesURL: String, cloneURL: String, mirrorURL: String, hooksURL: String, svnURL: String, homepage: String, language: JSONNull?, forksCount: Int, stargazersCount: Int, watchersCount: Int, size: Int, defaultBranch: String, openIssuesCount: Int, isTemplate: Bool, topics: [String], hasIssues: Bool, hasProjects: Bool, hasWiki: Bool, hasPages: Bool, hasDownloads: Bool, archived: Bool, disabled: Bool, pushedAt: String, createdAt: String, updatedAt: String, permissions: Permissions, templateRepository: JSONNull?, subscribersCount: Int, networkCount: Int, license: License) {
        self.id = id
        self.nodeID = nodeID
        self.name = name
        self.fullName = fullName
        self.owner = owner
        self.watchingElementPrivate = watchingElementPrivate
        self.htmlURL = htmlURL
        self.watchingElementDescription = watchingElementDescription
        self.fork = fork
        self.url = url
        self.archiveURL = archiveURL
        self.assigneesURL = assigneesURL
        self.blobsURL = blobsURL
        self.branchesURL = branchesURL
        self.collaboratorsURL = collaboratorsURL
        self.commentsURL = commentsURL
        self.commitsURL = commitsURL
        self.compareURL = compareURL
        self.contentsURL = contentsURL
        self.contributorsURL = contributorsURL
        self.deploymentsURL = deploymentsURL
        self.downloadsURL = downloadsURL
        self.eventsURL = eventsURL
        self.forksURL = forksURL
        self.gitCommitsURL = gitCommitsURL
        self.gitRefsURL = gitRefsURL
        self.gitTagsURL = gitTagsURL
        self.gitURL = gitURL
        self.issueCommentURL = issueCommentURL
        self.issueEventsURL = issueEventsURL
        self.issuesURL = issuesURL
        self.keysURL = keysURL
        self.labelsURL = labelsURL
        self.languagesURL = languagesURL
        self.mergesURL = mergesURL
        self.milestonesURL = milestonesURL
        self.notificationsURL = notificationsURL
        self.pullsURL = pullsURL
        self.releasesURL = releasesURL
        self.sshURL = sshURL
        self.stargazersURL = stargazersURL
        self.statusesURL = statusesURL
        self.subscribersURL = subscribersURL
        self.subscriptionURL = subscriptionURL
        self.tagsURL = tagsURL
        self.teamsURL = teamsURL
        self.treesURL = treesURL
        self.cloneURL = cloneURL
        self.mirrorURL = mirrorURL
        self.hooksURL = hooksURL
        self.svnURL = svnURL
        self.homepage = homepage
        self.language = language
        self.forksCount = forksCount
        self.stargazersCount = stargazersCount
        self.watchersCount = watchersCount
        self.size = size
        self.defaultBranch = defaultBranch
        self.openIssuesCount = openIssuesCount
        self.isTemplate = isTemplate
        self.topics = topics
        self.hasIssues = hasIssues
        self.hasProjects = hasProjects
        self.hasWiki = hasWiki
        self.hasPages = hasPages
        self.hasDownloads = hasDownloads
        self.archived = archived
        self.disabled = disabled
        self.pushedAt = pushedAt
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.permissions = permissions
        self.templateRepository = templateRepository
        self.subscribersCount = subscribersCount
        self.networkCount = networkCount
        self.license = license
    }
}

// MARK: - License
public struct License: Codable {
    public let key, name, spdxID: String
    public let url: String
    public let nodeID: String

    enum CodingKeys: String, CodingKey {
        case key, name
        case spdxID = "spdx_id"
        case url
        case nodeID = "node_id"
    }

    public init(key: String, name: String, spdxID: String, url: String, nodeID: String) {
        self.key = key
        self.name = name
        self.spdxID = spdxID
        self.url = url
        self.nodeID = nodeID
    }
}

// MARK: - Permissions
public struct Permissions: Codable {
    public let admin, push, pull: Bool

    public init(admin: Bool, push: Bool, pull: Bool) {
        self.admin = admin
        self.push = push
        self.pull = pull
    }
}

// MARK: - Encode/decode helpers

public class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    
    public var hashValue: Int {
        return 0
    }
    public func hash(into hasher: inout Hasher) {
        // No-op
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
