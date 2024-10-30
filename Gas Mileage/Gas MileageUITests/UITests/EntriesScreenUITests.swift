import XCTest
import Foundation

final class EntriesScreenUITests: BaseUITest {

	// MARK: Test methods
	func testEntriesScreenAllElementsVerification() {
		Helpers()
			.waitForApplicationToLaunch()
		MainScreen()
			.tapEntriesTabBarButton()
		EntriesScreen()
			.verifyTabBarElements()
			.verifyAllStaticElements()
			.verifyAllEntries()
		SoftAssert.shared.checkForFailures()
	}
	
	func testEntriesScreenDeleteEntry() {
		var cellID = ""
		
		Helpers()
			.waitForApplicationToLaunch()
		MainScreen()
			.tapEntriesTabBarButton()
		EntriesScreen()
			.deleteFirstEntry { newValue in
				cellID = newValue
			}
			.verifyEntryIsDeleted(odometerValue: cellID)
		SoftAssert.shared.checkForFailures()
	}
}
