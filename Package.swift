// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OderoPaySdk",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "OderoPaySdk",
            targets: ["OderoPaySdk"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .binaryTarget(
                 name: "OderoPaySdk",
                 url: "https://gitlab.com/kafatech/oderopayframework/-/raw/master/OderoPaySdk.zip?inline=false",
                 checksum: "7e6fac906b672a08151703422d678e0071b5645111e84fd5caff282a034e8b47"
             )
    ]
)
