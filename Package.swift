// swift-tools-version: 5.5

// WARNING:
// This file is automatically generated.
// Do not edit it by hand because the contents will be replaced.

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "Tip Calculator",
    platforms: [
        .iOS("15.2")
    ],
    products: [
        .iOSApplication(
            name: "Tip Calculator",
            targets: ["AppModule"],
            bundleIdentifier: "tipCalculatorSpaghoo",
            teamIdentifier: "9VS7Z57592",
            displayVersion: "1.0",
            bundleVersion: "3",
            iconAssetName: "AppIcon",
            accentColorAssetName: "AccentColor",
            supportedDeviceFamilies: [
                .pad,
                .phone
            ],
            supportedInterfaceOrientations: [
                .portrait,
                .landscapeRight,
                .landscapeLeft,
                .portraitUpsideDown(.when(deviceFamilies: [.pad]))
            ]
        )
    ],
    targets: [
        .executableTarget(
            name: "AppModule",
            path: "."
        )
    ]
)
