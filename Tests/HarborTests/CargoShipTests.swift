import XCTest
@testable import Harbor

final class CargoShipTests: XCTestCase {
    
    private let dock = CargoShipDock()

    func test_remove_whenCargoShipReturnsNoError_shouldNotThrows() throws {
        dock.ship(.removeCargo).error = nil

        XCTAssertNoThrow( try dock.removeCargo() )
    }

    func test_remove_whenCargoShipReturnsError_shouldThrows() throws {
        dock.ship(.removeCargo).error = NSError(domain: "some", code: 2)

        XCTAssertThrowsError( try dock.removeCargo() )
    }

    func test_currentCargo_shouldReturnValueAsInt() {
        let expectedValue = 123
        dock.ship(.currentCargo).value = expectedValue
        
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

        let parameters = dock.ship(.update).parameters
        XCTAssertEqual(parameters.first as? UUID, id)
        XCTAssertEqual(parameters.last as? Int, weight)
    }

}
