# WIP
This project work in progress.

# NotificationHub
NotificationHub is managed [GitHub notification](https://github.com/notifications) to use [SwiftUI](https://developer.apple.com/documentation/swiftui) and [Combine](https://developer.apple.com/documentation/combine) and [Swift Package Manager](https://github.com/apple/swift-package-manager) for iOS.  
So, this project example for *New Apple Technologies*.

## Environment
- Xcode 11 Beta
- iOS 13 Beta
- [GitHub Persnal Access Token](https://github.com/settings/tokens)

## Setup
Prepare created Secret.swift.
```
$ make secret
$ ls ./NotificationHub/Frameworks/NotificationHubCore/Secret/Secret.swift
```

And it edit to use [GitHub Persnal Access Token](https://github.com/settings/tokens).
```swift
public struct Secret {
	public struct GitHub {
		public static var token: String = YOUR_AUTHORIZATION_TOKEN
	}
}
```

[GitHub Persnal Access Token](https://github.com/settings/tokens) is required scope for`notifications`.
<img width="320px" src="https://user-images.githubusercontent.com/10897361/59777857-5a854300-92f0-11e9-83ab-8a63fda8a210.png" /><Paste>

## Features
- HTTP Request to use Combine.
- Add dependency with Nuke via SwiftPackageManager.
- Using @EnvironmentObject for control HUD
- Using @State and @Binding control for search notifications.
- Transition screen.

<img width="320px" src="https://user-images.githubusercontent.com/10897361/59778587-bd2b0e80-92f1-11e9-9202-d29f6df6ea9d.png" />

## LICENSE
NotificationHub is available under the MIT license. See the LICENSE file for more info.


