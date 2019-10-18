import Foundation

public enum UDGStringKey: String {
	case GitHubAccessToken
}


// MARK: - UserDefaults String Extension
extension UserDefaults {
	public func string(forKey key: UDGStringKey) -> String? {
		return string(forKey: key.rawValue)
	}
	public func set(_ value: String?, forKey key: UDGStringKey) {
		set(value, forKey: key.rawValue)
		synchronize()
	}
}
