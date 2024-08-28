/// Create a mock class for the anottated protocol
@attached(peer, names: suffixed(Dock))
public macro Dock() = #externalMacro(module: "HarborMacros", type: "DockMacro")
