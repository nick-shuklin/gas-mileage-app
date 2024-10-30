import XCTest
import Foundation

final class UITests: BaseUITest {

	// MARK: Test methods
	func testMainScreenAllElementsVerification() throws {
		Helpers()
			.waitForApplicationToLaunch()
		MainScreen()
			.verifyAllStaticElements()
			.verifyScrollViewEntries()
		SoftAssert.shared.checkForFailures()
	}
	
	func testEntriesScreenAllElementsVerification() throws {
		Helpers()
			.waitForApplicationToLaunch()
		MainScreen()
			.tapEntriesTabBarButton()
		EntriesScreen()
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
	
	func testTabBarElementsOnEachScreenVerification() throws {
		Helpers()
			.waitForApplicationToLaunch()
		MainScreen()
			.verifyTabBarElements()
			.tapEntriesTabBarButton()
		EntriesScreen()
			.verifyTabBarElements()
			.tapChartsTabBarButton()
		SoftAssert.shared.checkForFailures()
	}
	
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
