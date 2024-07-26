import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftDiagnostics

@main
struct HarborPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        DockMacro.self,
    ]
}

public struct DockMacro: PeerMacro {

    public static func expansion(
        of node: AttributeSyntax,
        providingPeersOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        let mappedProtocol = try ProtocolAtlas.mapProtocol(declaration)

        let enumName = TokenSyntax(stringLiteral: "\(mappedProtocol.declName)\(HarborDefinitions.functionsName.rawValue)")
        let typeAlias = TypeAliasFactory.make(
            named: enumName,
            isPublic: mappedProtocol.isPublic
        )
        let enumdecl = try EnumFactory.make(named: enumName, for: mappedProtocol)
        let functions = try FunctionFactory.make(
            mappedProtocol.memberBlock, 
            makePublic: mappedProtocol.isPublic
        )
        let varDecl = DeclSyntax(stringLiteral: HarborStatements.dockVar(enumName.text).statement)
        var block = MemberBlockSyntax(members: [
            MemberBlockItemSyntax(decl: typeAlias),
            MemberBlockItemSyntax(decl: varDecl),
            MemberBlockItemSyntax(decl: enumdecl)
        ])

        block.members.append(contentsOf: functions)
        let classdc = ClassDeclSyntax(
            modifiers: .make(public: mappedProtocol.isPublic),
            classKeyword: TokenSyntax.keyword(.class),
            name: .identifier("\(mappedProtocol.declName)Dock"),
            inheritanceClause: .defaultWith(mappedProtocol.name.text),
            memberBlock: block
        )

        return [DeclSyntax(classdc)]
    }

}
