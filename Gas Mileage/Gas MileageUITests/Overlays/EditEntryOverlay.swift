import Foundation
import XCTest

class EditEntryOverlay: BaseScreen {
	// MARK: - Static Screen Elements (in order top to the bottom, left to right how they displayed on the screen)
	private lazy var cancelButton = app.buttons[AccIDs.EditEntryOverlay.cancelButton.rawValue].firstMatch
	private lazy var navigationBarText = app.staticTexts[AccIDs.EditEntryOverlay.title.rawValue].firstMatch
	private lazy var saveEntryButton = app.buttons[AccIDs.EditEntryOverlay.saveButton.rawValue].firstMatch
	private lazy var fillupDatePicker = app.datePickers[AccIDs.EditEntryOverlay.fillUpDatePicker.rawValue].firstMatch
	private lazy var gasStationNamePicker = app.buttons[AccIDs.EditEntryOverlay.gasStationPicker.rawValue].firstMatch
	private lazy var odometerText = app.staticTexts[AccIDs.EditEntryOverlay.odometerText.rawValue].firstMatch
	private lazy var odometerTextField = app.staticTexts[AccIDs.EditEntryOverlay.odometerTextfield.rawValue].firstMatch
	private lazy var totalText = app.staticTexts[AccIDs.EditEntryOverlay.totalText.rawValue].firstMatch
	private lazy var totalTextField = app.staticTexts[AccIDs.EditEntryOverlay.totalTextfield.rawValue].firstMatch
	private lazy var priceText = app.staticTexts[AccIDs.EditEntryOverlay.priceText.rawValue].firstMatch
	private lazy var priceTextField = app.staticTexts[AccIDs.EditEntryOverlay.priceTextfield.rawValue].firstMatch
	private lazy var volumeText = app.staticTexts[AccIDs.EditEntryOverlay.volumeText.rawValue].firstMatch
	private lazy var volumeTextField = app.staticTexts[AccIDs.EditEntryOverlay.volumeTextfield.rawValue].firstMatch
	private lazy var tankFilledToggle = app.switches[AccIDs.EditEntryOverlay.tankFilledToggle.rawValue].firstMatch
	
	// MARK: - Dynamic Screen Element
	
	// MARK: - Strings
	private let failureMessageAddOn = "'Edit entry' overlay"
	
	init() {
		assertScreenIsDisplayed()
	}
	
	internal func assertScreenIsDisplayed() {
		runActivity(.screen, "Then verify \(failureMessageAddOn) is loaded") {
			XCTAssert(navigationBarText.wait(for: .long),
					  "\(err) \(failureMessageAddOn) is NOT displayed because 'Entry details' title is NOT displayed")
		}
	}
	
	// MARK: - Navigation & UI Interactions
	@discardableResult
	func tapCancelButton() -> Self {
		runActivity(.step, "Then tap 'Cancel' navigation bar button") {
			cancelButton.tapElement()
		}
		return self
	}
	
	@discardableResult
	func tapSaveEntryButton() -> Self {
		runActivity(.step, "Then tap 'Save entry' navigation bar button") {
			saveEntryButton.tapElement()
		}
		return self
	}
	
	@discardableResult
	func tapOnTankFilledToggle() -> Self {
		runActivity(.step, "Then tap 'Tank Filled' toggle") {
			tankFilledToggle.tapElement()
		}
		return self
	}
	
	// MARK: - Assertions
	@discardableResult
	func verifyAllStaticElements() -> Self {
		runActivity(.assert, "Then verify all static elements exists and labels match on \(failureMessageAddOn)") {
			SoftAssert.shared.assert(cancelButton.wait(),
									 "'Cancel' button doesn't exists on \(failureMessageAddOn)")
			SoftAssert.shared.assert(navigationBarText.wait(),
									 "Title text doesn't exists on \(failureMessageAddOn)")
			SoftAssert.shared.assert(saveEntryButton.wait(),
									 "'Save' button doesn't exists on \(failureMessageAddOn)")
			SoftAssert.shared.assert(fillupDatePicker.wait(),
									 "'Fill Up Date' picker doesn't exists on \(failureMessageAddOn)")
			SoftAssert.shared.assert(gasStationNamePicker.wait(),
									 "'Gas Station Name' picker doesn't exists on \(failureMessageAddOn)")
			SoftAssert.shared.assert(odometerText.wait(),
									 "'Odometer' text doesn't exists on \(failureMessageAddOn)")
			SoftAssert.shared.assert(odometerTextField.wait(),
									 "'Odometer' text field doesn't exists on \(failureMessageAddOn)")
			SoftAssert.shared.assert(totalText.wait(),
									 "'Total' text doesn't exists on \(failureMessageAddOn)")
			SoftAssert.shared.assert(totalTextField.wait(),
									 "'Total' text field doesn't exists on \(failureMessageAddOn)")
			SoftAssert.shared.assert(priceText.wait(),
									 "'Price' text doesn't exists on \(failureMessageAddOn)")
			SoftAssert.shared.assert(priceTextField.wait(),
									 "'Price' text field doesn't exists on \(failureMessageAddOn)")
			SoftAssert.shared.assert(volumeText.wait(),
									 "'Volume' text doesn't exists on \(failureMessageAddOn)")
			SoftAssert.shared.assert(volumeTextField.wait(),
									 "'Volume' text field doesn't exists on \(failureMessageAddOn)")
			SoftAssert.shared.assert(tankFilledToggle.wait(),
									 "'Volume' text field doesn't exists on \(failureMessageAddOn)")
			SoftAssert.shared.assert(tankFilledToggle.wait(),
									 "'Tank filled up?' toggle doesn't exists on \(failureMessageAddOn)")
		}
		return self
	}
}
