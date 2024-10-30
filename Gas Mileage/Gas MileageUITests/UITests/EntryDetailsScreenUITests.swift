import XCTest
import Foundation

final class EntryDetailsScreenUITests: BaseUITest {
	
	// MARK: Test methods
	func testEntryDetailsAllElementsVerification() throws {
		Helpers()
			.waitForApplicationToLaunch()
		MainScreen()
			.tapEntriesTabBarButton()
		EntriesScreen()
			.tapFirstEntryButton()
		EntryDetailsScreen()
			.verifyAllStaticElements()
		SoftAssert.shared.checkForFailures()
	}
}
