@freestanding(declaration, names: arbitrary)
public macro DeclFuncMacro() = #externalMacro(module: "Macros", type: "DeclFuncMacro")

public protocol MyProtocol {
	// Comment out the associatedtype to prevent the crash
	associatedtype Context

	#DeclFuncMacro
}

/*
 % swift build
 Building for debugging...
 error: compile command failed due to signal 11 (use -v to see invocation)
 Please submit a bug report (https://swift.org/contributing/#reporting-bugs) and include the crash backtrace.
 Stack dump:
 0.	Program arguments: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/swift-frontend -frontend -c -primary-file /Volumes/Data/Development/skrundz/MacroICE/Sources/MacroCrash/MacroCrash.swift -emit-dependencies-path /Volumes/Data/Development/skrundz/MacroICE/.build/arm64-apple-macosx/debug/MacroCrash.build/MacroCrash.d -emit-reference-dependencies-path /Volumes/Data/Development/skrundz/MacroICE/.build/arm64-apple-macosx/debug/MacroCrash.build/MacroCrash.swiftdeps -target arm64-apple-macosx10.15 -Xllvm -aarch64-use-tbi -enable-objc-interop -stack-check -sdk /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX15.2.sdk -I /Volumes/Data/Development/skrundz/MacroICE/.build/arm64-apple-macosx/debug/Modules -I /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/usr/lib -F /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/Library/Frameworks -color-diagnostics -enable-testing -g -debug-info-format=dwarf -dwarf-version=4 -module-cache-path /Volumes/Data/Development/skrundz/MacroICE/.build/arm64-apple-macosx/debug/ModuleCache -swift-version 6 -Onone -D SWIFT_PACKAGE -D DEBUG -new-driver-path /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/swift-driver -load-plugin-executable /Volumes/Data/Development/skrundz/MacroICE/.build/arm64-apple-macosx/debug/Macros-tool#Macros -empty-abi-descriptor -resource-dir /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/swift -enable-anonymous-context-mangled-names -file-compilation-dir /Volumes/Data/Development/skrundz/MacroICE -Xcc -fmodule-map-file=/Volumes/Data/Development/skrundz/MacroICE/.build/checkouts/swift-syntax/Sources/_SwiftSyntaxCShims/include/module.modulemap -Xcc -I -Xcc /Volumes/Data/Development/skrundz/MacroICE/.build/checkouts/swift-syntax/Sources/_SwiftSyntaxCShims/include -Xcc -isysroot -Xcc /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX15.2.sdk -Xcc -F -Xcc /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/Library/Frameworks -Xcc -fPIC -Xcc -g -module-name MacroCrash -package-name macroice -disable-clang-spi -target-sdk-version 15.2 -target-sdk-name macosx15.2 -external-plugin-path /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/usr/lib/swift/host/plugins#/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/usr/bin/swift-plugin-server -external-plugin-path /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/usr/local/lib/swift/host/plugins#/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/usr/bin/swift-plugin-server -plugin-path /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/swift/host/plugins -plugin-path /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/local/lib/swift/host/plugins -parse-as-library -o /Volumes/Data/Development/skrundz/MacroICE/.build/arm64-apple-macosx/debug/MacroCrash.build/MacroCrash.swift.o -index-store-path /Volumes/Data/Development/skrundz/MacroICE/.build/arm64-apple-macosx/debug/index/store -index-system-modules
 1.	Apple Swift version 6.0.3 (swiftlang-6.0.3.1.10 clang-1600.0.30.1)
 2.	Compiling with the current language version
 3.	While evaluating request IRGenRequest(IR Generation for file "/Volumes/Data/Development/skrundz/MacroICE/Sources/MacroCrash/MacroCrash.swift")
 4.	While emitting IR for source file /Volumes/Data/Development/skrundz/MacroICE/Sources/MacroCrash/MacroCrash.swift
 5.	While emitting metadata for 'MyProtocol' (at /Volumes/Data/Development/skrundz/MacroICE/Sources/MacroCrash/MacroCrash.swift:4:8)
 Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
 0  swift-frontend           0x0000000109e0aa9c llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 56
 1  swift-frontend           0x0000000109e08cf0 llvm::sys::RunSignalHandlers() + 112
 2  swift-frontend           0x0000000109e0b068 SignalHandler(int) + 292
 3  libsystem_platform.dylib 0x0000000182420184 _sigtramp + 56
 4  swift-frontend           0x0000000104d37e50 swift::SILWitnessVisitor<(anonymous namespace)::WitnessTableLayout>::visitProtocolDecl(swift::ProtocolDecl*) + 1132
 5  swift-frontend           0x0000000104d37e50 swift::SILWitnessVisitor<(anonymous namespace)::WitnessTableLayout>::visitProtocolDecl(swift::ProtocolDecl*) + 1132
 6  swift-frontend           0x0000000104d377dc swift::irgen::TypeConverter::getProtocolInfo(swift::ProtocolDecl*, swift::irgen::ProtocolInfoKind) + 288
 7  swift-frontend           0x0000000104cee69c swift::irgen::IRGenModule::emitProtocolDecl(swift::ProtocolDecl*) + 2568
 8  swift-frontend           0x0000000104c3154c swift::irgen::IRGenModule::emitGlobalDecl(swift::Decl*) + 284
 9  swift-frontend           0x0000000104c31244 swift::irgen::IRGenModule::emitSourceFile(swift::SourceFile&) + 316
 10 swift-frontend           0x0000000104da5654 swift::IRGenRequest::evaluate(swift::Evaluator&, swift::IRGenDescriptor) const + 4872
 11 swift-frontend           0x0000000104dedba8 swift::SimpleRequest<swift::IRGenRequest, swift::GeneratedModule (swift::IRGenDescriptor), (swift::RequestFlags)9>::evaluateRequest(swift::IRGenRequest const&, swift::Evaluator&) + 176
 12 swift-frontend           0x0000000104dae394 swift::IRGenRequest::OutputType swift::Evaluator::getResultUncached<swift::IRGenRequest, swift::IRGenRequest::OutputType swift::evaluateOrFatal<swift::IRGenRequest>(swift::Evaluator&, swift::IRGenRequest)::'lambda'()>(swift::IRGenRequest const&, swift::IRGenRequest::OutputType swift::evaluateOrFatal<swift::IRGenRequest>(swift::Evaluator&, swift::IRGenRequest)::'lambda'()) + 784
 13 swift-frontend           0x0000000104da7e90 swift::performIRGeneration(swift::FileUnit*, swift::IRGenOptions const&, swift::TBDGenOptions const&, std::__1::unique_ptr<swift::SILModule, std::__1::default_delete<swift::SILModule>>, llvm::StringRef, swift::PrimarySpecificPaths const&, llvm::StringRef, llvm::GlobalVariable**) + 180
 14 swift-frontend           0x00000001047b74bc generateIR(swift::IRGenOptions const&, swift::TBDGenOptions const&, std::__1::unique_ptr<swift::SILModule, std::__1::default_delete<swift::SILModule>>, swift::PrimarySpecificPaths const&, llvm::StringRef, llvm::PointerUnion<swift::ModuleDecl*, swift::SourceFile*>, llvm::GlobalVariable*&, llvm::ArrayRef<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char>>>) + 156
 15 swift-frontend           0x00000001047b2ce4 performCompileStepsPostSILGen(swift::CompilerInstance&, std::__1::unique_ptr<swift::SILModule, std::__1::default_delete<swift::SILModule>>, llvm::PointerUnion<swift::ModuleDecl*, swift::SourceFile*>, swift::PrimarySpecificPaths const&, int&, swift::FrontendObserver*) + 2176
 16 swift-frontend           0x00000001047b1bd0 swift::performCompileStepsPostSema(swift::CompilerInstance&, int&, swift::FrontendObserver*) + 984
 17 swift-frontend           0x00000001047b4e88 performCompile(swift::CompilerInstance&, int&, swift::FrontendObserver*) + 1684
 18 swift-frontend           0x00000001047b3bb4 swift::performFrontend(llvm::ArrayRef<char const*>, char const*, void*, swift::FrontendObserver*) + 3572
 19 swift-frontend           0x000000010473aa5c swift::mainEntry(int, char const**) + 3680
 20 dyld                     0x0000000182068274 start + 2840
 */
