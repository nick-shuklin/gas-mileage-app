import XCTest
import Foundation

final class E2EUItests: BaseUITest {
	
	// MARK: Test methods
	func testAddEntryWithValidData() {
		var firstEntryOdometerValue = ""
		let totalValue = "86"
		let priceValue = "4.56"
		let volumeValue = "18.86"
		let mileageFromLastFillUp = 50
		var newOdometerValue = ""
		
		Helpers()
			.waitForApplicationToLaunch()
		MainScreen()
			.tapEntriesTabBarButton()
		EntriesScreen()
			.getOdometerFromFirstEntry(&firstEntryOdometerValue)
			.tapAddEntryButton()
		EditEntryOverlay()
			.typeInAllFields(odometer: {
				newOdometerValue = String((Int(firstEntryOdometerValue) ?? 0) + mileageFromLastFillUp)
				return newOdometerValue
			}(),
							 total: totalValue,
							 price: priceValue,
							 volume: volumeValue)
			.tapSaveEntryButton()
			.verifyAlert(isDisplayed: false)
		EntriesScreen()
			.verifyEntry(isDisplayed: false,
						 odometerValue: newOdometerValue)
		SoftAssert.shared.checkForFailures()
		
		addTeardownBlock {
			EntriesScreen()
				.deleteFirstEntry()
		}
	}
	
	func testAddEntryWithInvalidData() {
		var firstEntryOdometerValue = ""
		let totalValue = "86"
		let priceValue = "4.56"
		let volumeValue = "18.86"
		let mileageFromLastFillUp = 50
		var newOdometerValue = ""
		
		Helpers()
			.waitForApplicationToLaunch()
		MainScreen()
			.tapEntriesTabBarButton()
		EntriesScreen()
			.getOdometerFromFirstEntry(&firstEntryOdometerValue)
			.tapAddEntryButton()
		EditEntryOverlay()
			.typeInAllFields(odometer: {
				newOdometerValue = String((Int(firstEntryOdometerValue) ?? 0) - mileageFromLastFillUp)
				return newOdometerValue
			}(),
							 total: totalValue,
							 price: priceValue,
							 volume: volumeValue)
			.tapSaveEntryButton()
			.verifyAlert(isDisplayed: true)
			.tapAlertCancelButton()
		EntriesScreen()
			.verifyEntry(isDisplayed: false,
						 odometerValue: newOdometerValue)
		SoftAssert.shared.checkForFailures()
	}
}
