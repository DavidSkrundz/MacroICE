import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct SupermanPlugin: CompilerPlugin {
	let providingMacros: [Macro.Type] = [
		DeclExtensionMacro.self,
		DeclStructFuncMacro.self,
	]
}

import SwiftSyntax

public struct DeclExtensionMacro: ExtensionMacro {
	public static func expansion(of node: AttributeSyntax,
								 attachedTo declaration: some DeclGroupSyntax,
								 providingExtensionsOf type: some TypeSyntaxProtocol,
								 conformingTo protocols: [TypeSyntax],
								 in context: some MacroExpansionContext) throws -> [ExtensionDeclSyntax] {
		return [
			ExtensionDeclSyntax(
				extendedType: type,
				memberBlock: MemberBlockSyntax(members: [])
			),
		]
	}
}

struct DeclStructFuncMacro: DeclarationMacro {
	static func expansion(of node: some FreestandingMacroExpansionSyntax,
						  in context: some MacroExpansionContext) throws -> [DeclSyntax] {
		let type = node.arguments.first!.expression.as(DeclReferenceExprSyntax.self)!.baseName
		return ["func Gen\(raw: type)() {}"]
	}
}
