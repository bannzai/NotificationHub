# NotificationHub
NotificationHub is managed [GitHub notification](https://github.com/notifications).  
Using [SwiftUI](https://developer.apple.com/documentation/swiftui) and [Combine](https://developer.apple.com/documentation/combine) and [Swift Package Manager](https://github.com/apple/swift-package-manager) for iOS.  

## Environment
- Over Xcode 11.0
- Over iOS 13.0
- [Registration GitHub OAuth Apps](https://github.com/settings/developers)

## Setup
**NotificationHub** is necessary secret informations for running application.
You can setup this secret information files with `$make setup`.

```
$ make setup
```

But it maybe got error about `XXX unbound variable`.
So, It must be to prepared secret variables as environment variablse when exec `$ make setup`.

The following environment variables must be prepared.

- GITHUB_CLIENT_ID 
  * GitHub OAuth Application Client ID
- GITHUB_CLIENT_SECRET
  * GitHub OAuth Application Client Secret
- GITHUB_NOTIFICATION_MANAGER_URL_SCHEMA
  * GitHub OAuth Application Callback URL. It is used custom URL schema (e.g awesomeapp://)

After exported above environment variables, to try `$ make setup` again.


After the execution `$make setup` you can confirm Secret.swift and Info.plist are created same directory of below files named by `.sample`.
1. [Secret.swift.sample](https://github.com/bannzai/NotificationHub/blob/master/NotificationHub/Frameworks/NotificationHubCore/Secret/Secret.swift.sample)
1. [Info.plist.sample](https://github.com/bannzai/NotificationHub/blob/master/NotificationHub/Info.plist.sample)

## This Project Features
- Use SwiftUI
- Use Combine
- Install Library via Swift Package Manager 
- Architecture is Redux
- Use bitrise

<img width=300px src="https://user-images.githubusercontent.com/10897361/67378947-04d4e600-f5c3-11e9-9cbd-e4f178ab94b8.jpg" />

## Contact and Contributions
If you contact me(or us) about bug report, improved, question technology, [Please create issue](https://github.com/bannzai/NotificationHub/issues/new).
Of course, I'm looking forward your to pull request is also waiting.

## Link
#### App Store
NotificationHub: https://apps.apple.com/jp/app/notificationhub/id1484099869?l=en

## LICENSE
NotificationHub is available under the MIT license. See the LICENSE file for more info.


