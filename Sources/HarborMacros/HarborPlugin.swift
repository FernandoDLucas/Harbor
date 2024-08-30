import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftDiagnostics

@main
public struct HarborPlugin: CompilerPlugin {

    public init() {}

    public let providingMacros: [Macro.Type] = [
        DockMacro.self
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
        let mappedFuncs = try FunctionAtlas.mapFunctions(mappedProtocol.memberBlock)
        let enumdecl = try EnumFactory.make(
            named: enumName,
            isPublic: mappedProtocol.isPublic,
            funcs: mappedFuncs
        )
        let functions = try FunctionFactory.make(
            functions: mappedFuncs,
            makePublic: mappedProtocol.isPublic
        )
        let varDecl = DeclSyntax(
            stringLiteral: HarborStatements.dockVar(mappedProtocol.isPublic, enumName.text).statement
        )
        let protcInit = DeclSyntax(
            stringLiteral: """
            \(mappedProtocol.isPublic ? "public" : "") init() {}
            """
        )
        var block = MemberBlockSyntax(members: [
            MemberBlockItemSyntax(decl: typeAlias),
            MemberBlockItemSyntax(decl: varDecl),
            MemberBlockItemSyntax(decl: protcInit),
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
