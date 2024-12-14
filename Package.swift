// swift-tools-version: 6.0

import PackageDescription
import CompilerPluginSupport

let package = Package(
	name: "MacroCrash",
	platforms: [
		.macOS(.v10_15),
		.iOS(.v13),
		.tvOS(.v13),
		.watchOS(.v6),
		.macCatalyst(.v13),
	],
	products: [
		.library(
			name: "MacroCrash",
			targets: ["MacroCrash"]
		),
	],
	dependencies: [
		.package(url: "https://github.com/apple/swift-syntax.git", from: "600.0.0"),
	],
	targets: [
		.macro(
			name: "Macros",
			dependencies: [
				.product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
				.product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
			]
		),
		.target(name: "MacroCrash", dependencies: ["Macros"]),
	]
)
