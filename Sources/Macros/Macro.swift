import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct SupermanPlugin: CompilerPlugin {
	let providingMacros: [Macro.Type] = [
		DeclFuncMacro.self,
	]
}

import SwiftSyntax

public struct DeclFuncMacro: DeclarationMacro {
	public static func expansion(of node: some FreestandingMacroExpansionSyntax,
								 in context: some MacroExpansionContext) throws -> [DeclSyntax] {
		let funcName = context.makeUniqueName("macroFunc")
		return ["func \(funcName)()"]
	}
}
