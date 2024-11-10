// swift-tools-version:5.9

import PackageDescription

let SwiftWin32: Package =
  Package(name: "SwiftWin32",
          products: [
            .library(name: "SwiftWin32",
                      type: .dynamic,
                      targets: ["SwiftWin32"]),
            .library(name: "SwiftWin32UI",
                      type: .dynamic,
                      targets: ["SwiftWin32UI"]),
            .executable(name: "UICatalog", targets: ["UICatalog"]),
            .executable(name: "Calculator", targets: ["Calculator"]),
          ],
          dependencies: [
            .package(path: "Packages/swift-log"),
            .package(path: "Packages/swift-collections"),
            .package(path: "Packages/cassowary"),
            .package(path: "Packages/SwiftCOM"),
          ],
          targets: [
            .target(name: "CoreAnimation",
                    path: "Sources/SwiftWin32/CoreAnimation"),
            .target(name: "CoreGraphics",
                    path: "Sources/SwiftWin32/CoreGraphics"),
            .target(name: "SwiftWin32",
                    dependencies: [
                      "CoreAnimation",
                      "CoreGraphics",
                      .product(name: "Logging", package: "swift-log"),
                      .product(name: "OrderedCollections",
                               package: "swift-collections"),
                      .product(name: "cassowary", package: "cassowary"),
                      .product(name: "SwiftCOM", package: "SwiftCOM"),
                    ],
                    path: "Sources/SwiftWin32",
                    exclude: [
                      "CoreAnimation",
                      "CoreGraphics",
                      "CMakeLists.txt"
                    ],
                    swiftSettings: [
                      .enableExperimentalFeature("AccessLevelOnImport"),
                    ],
                    linkerSettings: [
                      .linkedLibrary("User32"),
                      .linkedLibrary("ComCtl32"),
                    ]),
            .target(name: "SwiftWin32UI",
                    dependencies: ["SwiftWin32"],
                    path: "Sources/SwiftWin32UI",
                    exclude: ["CMakeLists.txt"]),
            .executableTarget(name: "Calculator",
                              dependencies: ["SwiftWin32"],
                              path: "Examples/Calculator",
                              exclude: [
                                "CMakeLists.txt",
                                "Calculator.exe.manifest",
                                "Info.plist",
                              ],
                              swiftSettings: [
                                .unsafeFlags(["-parse-as-library"])
                              ]),
            .executableTarget(name: "UICatalog",
                              dependencies: ["SwiftWin32"],
                              path: "Examples/UICatalog",
                              exclude: [
                                "CMakeLists.txt",
                                "Info.plist",
                                "UICatalog.exe.manifest",
                              ],
                              resources: [
                                .copy("Assets/CoffeeCup.jpg")
                              ],
                              swiftSettings: [
                                .unsafeFlags(["-parse-as-library"])
                              ]),
            .target(name: "TestUtilities", path: "Tests/Utilities"),
            .testTarget(name: "AutoLayoutTests", dependencies: ["SwiftWin32"]),
            .testTarget(name: "CoreGraphicsTests", dependencies: ["CoreGraphics"]),
            .testTarget(name: "SupportTests", dependencies: ["SwiftWin32"]),
            .testTarget(name: "UICoreTests",
                        dependencies: ["SwiftWin32", "TestUtilities"])
          ])
