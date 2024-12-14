@attached(extension, names: arbitrary)
public macro DeclExtension() = #externalMacro(module: "Macros", type: "DeclExtensionMacro")

@freestanding(declaration, names: arbitrary)
public macro DeclStructFunc(_ struct: Any.Type) = #externalMacro(module: "Macros", type: "DeclStructFuncMacro")

/*
 There are multiple ways to avoid the compiler crash

 1. Comment out the attached macro
 2. Comment out the associatedtype
 3. Comment out one of the extensions
 4. Uncomment the fifth extension
 */

// Comment out the attached macro to prevent the crash
@DeclExtension
public protocol SyntaxVisitor {
	// Comment out the associatedtype to prevent the crash
	associatedtype Context
}

struct StructOne {}
extension SyntaxVisitor {
	#DeclStructFunc(StructOne)
}

struct StructTwo {}
extension SyntaxVisitor {
	#DeclStructFunc(StructTwo)
}

struct StructThree {}
extension SyntaxVisitor {
	#DeclStructFunc(StructThree)
}

// Comment out any of the four extensions to prevent the crash
struct StructFour {}
extension SyntaxVisitor {
	#DeclStructFunc(StructFour)
}

// Uncomment this extension to prevent the crash
//struct StructFive {}
//extension SyntaxVisitor {
//	#DeclStructFunc(StructFive)
//}

/*
 % swift build
 Building for debugging...
 error: emit-module command failed due to signal 11 (use -v to see invocation)
 Please submit a bug report (https://swift.org/contributing/#reporting-bugs) and include the crash backtrace.
 Stack dump:
 0.	Program arguments: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/swift-frontend -frontend -emit-module -experimental-skip-non-inlinable-function-bodies-without-types /Volumes/Data/Development/skrundz/MacroICE/Sources/MacroCrash/MacroCrash.swift -target arm64-apple-macosx10.15 -Xllvm -aarch64-use-tbi -enable-objc-interop -stack-check -sdk /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX15.2.sdk -I /Volumes/Data/Development/skrundz/MacroICE/.build/arm64-apple-macosx/debug/Modules -I /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/usr/lib -F /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/Library/Frameworks -color-diagnostics -enable-testing -g -debug-info-format=dwarf -dwarf-version=4 -module-cache-path /Volumes/Data/Development/skrundz/MacroICE/.build/arm64-apple-macosx/debug/ModuleCache -swift-version 6 -Onone -D SWIFT_PACKAGE -D DEBUG -new-driver-path /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/swift-driver -load-plugin-executable /Volumes/Data/Development/skrundz/MacroICE/.build/arm64-apple-macosx/debug/Macros-tool#Macros -empty-abi-descriptor -resource-dir /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/swift -enable-anonymous-context-mangled-names -file-compilation-dir /Volumes/Data/Development/skrundz/MacroICE -Xcc -fmodule-map-file=/Volumes/Data/Development/skrundz/MacroICE/.build/checkouts/swift-syntax/Sources/_SwiftSyntaxCShims/include/module.modulemap -Xcc -I -Xcc /Volumes/Data/Development/skrundz/MacroICE/.build/checkouts/swift-syntax/Sources/_SwiftSyntaxCShims/include -Xcc -isysroot -Xcc /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX15.2.sdk -Xcc -F -Xcc /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/Library/Frameworks -Xcc -fPIC -Xcc -g -module-name MacroCrash -package-name macroice -disable-clang-spi -target-sdk-version 15.2 -target-sdk-name macosx15.2 -external-plugin-path /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/usr/lib/swift/host/plugins#/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/usr/bin/swift-plugin-server -external-plugin-path /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/usr/local/lib/swift/host/plugins#/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/usr/bin/swift-plugin-server -plugin-path /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/swift/host/plugins -plugin-path /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/local/lib/swift/host/plugins -emit-module-doc-path /Volumes/Data/Development/skrundz/MacroICE/.build/arm64-apple-macosx/debug/Modules/MacroCrash.swiftdoc -emit-module-source-info-path /Volumes/Data/Development/skrundz/MacroICE/.build/arm64-apple-macosx/debug/Modules/MacroCrash.swiftsourceinfo -emit-objc-header-path /Volumes/Data/Development/skrundz/MacroICE/.build/arm64-apple-macosx/debug/MacroCrash.build/MacroCrash-Swift.h -emit-dependencies-path /Volumes/Data/Development/skrundz/MacroICE/.build/arm64-apple-macosx/debug/MacroCrash.build/MacroCrash.emit-module.d -parse-as-library -o /Volumes/Data/Development/skrundz/MacroICE/.build/arm64-apple-macosx/debug/Modules/MacroCrash.swiftmodule -emit-abi-descriptor-path /Volumes/Data/Development/skrundz/MacroICE/.build/arm64-apple-macosx/debug/Modules/MacroCrash.abi.json
 1.	Apple Swift version 6.0.3 (swiftlang-6.0.3.1.10 clang-1600.0.30.1)
 2.	Compiling with the current language version
 3.	While evaluating request TypeCheckSourceFileRequest(source_file "/Volumes/Data/Development/skrundz/MacroICE/Sources/MacroCrash/MacroCrash.swift")
 4.	While type-checking 'SyntaxVisitor' (at /Volumes/Data/Development/skrundz/MacroICE/Sources/MacroCrash/MacroCrash.swift:18:8)
 5.	While type-checking 'Context' (at /Volumes/Data/Development/skrundz/MacroICE/Sources/MacroCrash/MacroCrash.swift:20:2)
 6.	While evaluating request CheckRedeclarationRequest(MacroCrash.(file).SyntaxVisitor.Context@/Volumes/Data/Development/skrundz/MacroICE/Sources/MacroCrash/MacroCrash.swift:20:17, MacroCrash.(file).SyntaxVisitor@/Volumes/Data/Development/skrundz/MacroICE/Sources/MacroCrash/MacroCrash.swift:18:17)
 7.	While evaluating request DirectLookupRequest(directly looking up 'Context' on MacroCrash.(file).SyntaxVisitor@/Volumes/Data/Development/skrundz/MacroICE/Sources/MacroCrash/MacroCrash.swift:18:17 with options {  })
 Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
 0  swift-frontend           0x00000001063aea9c llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 56
 1  swift-frontend           0x00000001063accf0 llvm::sys::RunSignalHandlers() + 112
 2  swift-frontend           0x00000001063af068 SignalHandler(int) + 292
 3  libsystem_platform.dylib 0x0000000182420184 _sigtramp + 56
 4  swift-frontend           0x00000001026b9c8c swift::DirectLookupRequest::evaluate(swift::Evaluator&, swift::DirectLookupDescriptor) const + 6912
 5  swift-frontend           0x00000001026d3824 swift::SimpleRequest<swift::DirectLookupRequest, llvm::TinyPtrVector<swift::ValueDecl*> (swift::DirectLookupDescriptor), (swift::RequestFlags)17>::evaluateRequest(swift::DirectLookupRequest const&, swift::Evaluator&) + 36
 6  swift-frontend           0x00000001026ca60c swift::DirectLookupRequest::OutputType swift::Evaluator::getResultUncached<swift::DirectLookupRequest, swift::DirectLookupRequest::OutputType swift::evaluateOrDefault<swift::DirectLookupRequest>(swift::Evaluator&, swift::DirectLookupRequest, swift::DirectLookupRequest::OutputType)::'lambda'()>(swift::DirectLookupRequest const&, swift::DirectLookupRequest::OutputType swift::evaluateOrDefault<swift::DirectLookupRequest>(swift::Evaluator&, swift::DirectLookupRequest, swift::DirectLookupRequest::OutputType)::'lambda'()) + 552
 7  swift-frontend           0x00000001026b8148 swift::DirectLookupRequest::OutputType swift::evaluateOrDefault<swift::DirectLookupRequest>(swift::Evaluator&, swift::DirectLookupRequest, swift::DirectLookupRequest::OutputType) + 196
 8  swift-frontend           0x00000001026b8040 swift::NominalTypeDecl::lookupDirect(swift::DeclName, swift::SourceLoc, swift::optionset::OptionSet<swift::NominalTypeDecl::LookupDirectFlags, unsigned int>) + 264
 9  swift-frontend           0x0000000102123150 swift::CheckRedeclarationRequest::evaluate(swift::Evaluator&, swift::ValueDecl*, swift::NominalTypeDecl*) const + 376
 10 swift-frontend           0x0000000102129494 (anonymous namespace)::DeclChecker::visit(swift::Decl*) + 5856
 11 swift-frontend           0x0000000102128448 (anonymous namespace)::DeclChecker::visit(swift::Decl*) + 1684
 12 swift-frontend           0x0000000102127da4 swift::TypeChecker::typeCheckDecl(swift::Decl*) + 152
 13 swift-frontend           0x000000010220f01c swift::TypeCheckSourceFileRequest::evaluate(swift::Evaluator&, swift::SourceFile*) const + 660
 14 swift-frontend           0x0000000102216680 swift::TypeCheckSourceFileRequest::OutputType swift::Evaluator::getResultUncached<swift::TypeCheckSourceFileRequest, swift::TypeCheckSourceFileRequest::OutputType swift::evaluateOrDefault<swift::TypeCheckSourceFileRequest>(swift::Evaluator&, swift::TypeCheckSourceFileRequest, swift::TypeCheckSourceFileRequest::OutputType)::'lambda'()>(swift::TypeCheckSourceFileRequest const&, swift::TypeCheckSourceFileRequest::OutputType swift::evaluateOrDefault<swift::TypeCheckSourceFileRequest>(swift::Evaluator&, swift::TypeCheckSourceFileRequest, swift::TypeCheckSourceFileRequest::OutputType)::'lambda'()) + 620
 15 swift-frontend           0x000000010220ed6c swift::performTypeChecking(swift::SourceFile&) + 328
 16 swift-frontend           0x000000010112be48 swift::CompilerInstance::performSema() + 332
 17 swift-frontend           0x0000000100d58df0 performCompile(swift::CompilerInstance&, int&, swift::FrontendObserver*) + 1532
 18 swift-frontend           0x0000000100d57bb4 swift::performFrontend(llvm::ArrayRef<char const*>, char const*, void*, swift::FrontendObserver*) + 3572
 19 swift-frontend           0x0000000100cdea5c swift::mainEntry(int, char const**) + 3680
 20 dyld                     0x0000000182068274 start + 2840
 */
