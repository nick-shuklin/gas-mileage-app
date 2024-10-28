import XCTest
import Foundation

final class UITests: BaseUITest {

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
