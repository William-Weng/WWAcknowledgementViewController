// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WWAcknowledgementViewController",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(name: "WWAcknowledgementViewController", targets: ["WWAcknowledgementViewController"]),
    ],
    dependencies: [
        .package(url: "https://github.com/William-Weng/WWJavaScriptContext_Markdown", from: "1.1.0")
    ],
    targets: [
        .target(name: "WWAcknowledgementViewController", dependencies: ["WWJavaScriptContext_Markdown"], resources: [.copy("Privacy")]),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
