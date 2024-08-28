import XCTest
@testable import Harbor

final class CargoShipTests: XCTestCase {
    
    private let dock = CargoShipDock()

    func test_remove_whenCargoShipReturnsNoError_shouldNotThrows() throws {
        dock.ship(.removeCargo).action(.anchor(nil))

        XCTAssertNoThrow( try dock.removeCargo() )
    }

    func test_remove_whenCargoShipReturnsError_shouldThrows() throws {
        let error = NSError(domain: "some", code: 2)
        dock.ship(.removeCargo).action(.anchor(error))

        XCTAssertThrowsError( try dock.removeCargo() )
    }

    func test_currentCargo_shouldReturnValueAsInt() {
        let expectedValue = 123
        dock.ship(.currentCargo).action(.deploy(expectedValue))
        
        let actualValue = dock.currentCargo()
        
        XCTAssertEqual(actualValue, expectedValue)
    }

    func test_update_shouldSendExpectedParameters() throws {
        let id = UUID()
        let weight = 100

        try dock.update(
            id: id,
            weight: weight
        )

        let validation = dock.check(ship: .update) { parameters in
            parameters.first as? UUID == id && parameters.last as? Int == weight
        }
        XCTAssertTrue(validation)
    }

}
