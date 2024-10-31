import XCTest
import Foundation

final class MainScreenUITests: BaseUITest {

	// MARK: Test methods
	func testMainScreenAllElementsVerification() {
		Helpers()
			.waitForApplicationToLaunch()
		MainScreen()
			.verifyTabBarElements()
			.verifyAllStaticElements()
			.verifyScrollViewEntries()
		SoftAssert.shared.checkForFailures()
	}
}
