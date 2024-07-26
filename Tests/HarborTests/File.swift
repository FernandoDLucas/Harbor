import XCTest
@testable import Harbor

final class SommeTests: XCTestCase {
    
    private let dock = GetUserUseCasingDock()
    private lazy var sut = Repo(getUser: dock)
    
    
    func test_() throws {
        let expectedValue = "someValue"
        dock.ship(.that).deploy(expectedValue)

        let result = try sut.retrieve()

        XCTAssertEqual(result, expectedValue)
    }

    func test_2() {
        dock.ship(.this).deploy(nil)

        let result = sut.retor()

        XCTAssertNil(result)
    }

}

final class Repo {
    
    private let getUser: GetUserUseCasing
    
    init(getUser: GetUserUseCasing) {
        self.getUser = getUser
    }

    func retrieve() throws -> String {
        getUser.that()
    }

    func retor()  -> String? {
        getUser.this()
    }

}
