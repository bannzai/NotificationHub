# WIP
This project work in progress.

# GitHubNotificationManager
GitHubNotificationManager is managed [GitHub notification](https://github.com/notifications) to use [SwiftUI](https://developer.apple.com/documentation/swiftui) and [Combine](https://developer.apple.com/documentation/combine).  
So, this project example for *New Apple Technologies*.

## Environment
- Xcode 11 Beta
- iOS 13 Beta
- [GitHub Persnal Access Token](https://github.com/settings/tokens)

## Setup
Prepare created Secret.swift.
```
$ make secret
$ ls ./GitHubNotificationManager/Frameworks/GitHubNotificationManagerCore/Secret/Secret.swift
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
- Using @EnvironmentObject, @State, @Binding.
- Transition screen.

## LICENSE
GitHubNotificationManager is available under the MIT license. See the LICENSE file for more info.


