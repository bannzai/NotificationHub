// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let watchingElements = try? newJSONDecoder().decode(WatchingElements.self, from: jsonData)

import Foundation

// MARK: - WatchingElement
public struct WatchingElement: Codable, Identifiable, Equatable {
    public let id: Int64
    public let nodeID: String
    public let name: String
    public let fullName: String
    public let owner: Owner
    public let notificationsUrl: String
    
    public var isReceiveNotification: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case nodeID = "node_id"
        case name
        case fullName = "full_name"
        case owner
        case notificationsUrl = "notifications_url"
        case isReceiveNotification = "is_receive_notification"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int64.self, forKey: .id)
        nodeID = try values.decode(String.self, forKey: .nodeID)
        name = try values.decode(String.self, forKey: .name)
        fullName = try values.decode(String.self, forKey: .fullName)
        owner = try values.decode(Owner.self, forKey: .owner)
        notificationsUrl = try values.decode(String.self, forKey: .notificationsUrl)
        isReceiveNotification = (try? values.decode(Bool.self, forKey: .isReceiveNotification)) ?? false
    }

    public init(id: Int64, nodeID: String, name: String, fullName: String, owner: Owner, notificationsUrl: String) {
        self.id = id
        self.nodeID = nodeID
        self.name = name
        self.fullName = fullName
        self.owner = owner
        self.notificationsUrl = notificationsUrl
        self.isReceiveNotification = false
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
