# tappxDemo
Demonstrates how to use Tappx for Ad provisioning in iOS apps (both banner and interstitial)

The repository was built on MacOS X - Mojave using Xcode 11.2.1 (11B53)

The Demo was written in Swift 5 and targets iOS 12.2 iPhone and iPads via the simulator

Requires the Google Ad Framework and Tappx Frameworks (see www.tappx.com for details)

Note: You must get your own app key from Tappx and set this in your $tappxKey environment variable. This value will be used to overwrite the privateData.plist property at build time (as part of a run script build phase).

