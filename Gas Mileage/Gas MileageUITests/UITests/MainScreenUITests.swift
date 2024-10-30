import XCTest
import Foundation

final class MainScreenUITests: BaseUITest {

	// MARK: Test methods
	func testMainScreenAllElementsVerification() throws {
		Helpers()
			.waitForApplicationToLaunch()
		MainScreen()
			.verifyTabBarElements()
			.verifyAllStaticElements()
			.verifyScrollViewEntries()
		SoftAssert.shared.checkForFailures()
	}
}
