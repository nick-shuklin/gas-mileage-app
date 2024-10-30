import XCTest
import Foundation

final class EntriesScreenUITests: BaseUITest {

	// MARK: Test methods
	func testEntriesScreenAllElementsVerification() throws {
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
	
	func testEntriesScreenDeleteEntry() throws {
		var cellID = ""
		
		Helpers()
			.waitForApplicationToLaunch()
		MainScreen()
			.tapEntriesTabBarButton()
		EntriesScreen()
			.deleteFirstEntry(&cellID)
			.verifyEntryIsDeleted(odometerValue: cellID)
		SoftAssert.shared.checkForFailures()
	}
}
