import XCTest
import Foundation

final class EditEntryScreenUITests: BaseUITest {

	// MARK: Test methods	
	func testEditEntryAllElementsVerification() throws {
		Helpers()
			.waitForApplicationToLaunch()
		MainScreen()
			.tapEntriesTabBarButton()
		EntriesScreen()
			.tapFirstEntryButton()
		EntryDetailsScreen()
			.tapEditEntryButton()
		EditEntryOverlay()
			.verifyAllStaticElements()
		SoftAssert.shared.checkForFailures()
	}
}
