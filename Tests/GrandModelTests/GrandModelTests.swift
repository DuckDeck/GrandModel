import XCTest
@testable import GrandModel

final class GrandModelTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(GrandModel().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
