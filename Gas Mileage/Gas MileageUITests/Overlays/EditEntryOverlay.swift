import Foundation
import XCTest

/// Screen object representing the Edit Entry overlay in the app.
class EditEntryOverlay: BaseScreen {
	
	// MARK: - Static Screen Elements
	// Elements are ordered top to bottom, left to right as displayed on the screen.
	
	private lazy var editEntryMainView = app.otherElements[AccIDs.EditEntryOverlay.editEntryMainView.rawValue].firstMatch
	private lazy var cancelButton = editEntryMainView.buttons[AccIDs.EditEntryOverlay.cancelButton.rawValue].firstMatch
	private lazy var navigationBarText = editEntryMainView.staticTexts[AccIDs.EditEntryOverlay.title.rawValue].firstMatch
	private lazy var saveEntryButton = editEntryMainView.buttons[AccIDs.EditEntryOverlay.saveButton.rawValue].firstMatch
	private lazy var fillupDatePicker = editEntryMainView.datePickers[AccIDs.EditEntryOverlay.fillUpDatePicker.rawValue].firstMatch
	private lazy var gasStationNamePicker = editEntryMainView.buttons[AccIDs.EditEntryOverlay.gasStationPicker.rawValue].firstMatch
	private lazy var odometerText = editEntryMainView.staticTexts[AccIDs.EditEntryOverlay.odometerText.rawValue].firstMatch
	private lazy var odometerTextField = editEntryMainView.textFields[AccIDs.EditEntryOverlay.odometerTextfield.rawValue].firstMatch
	private lazy var totalText = editEntryMainView.staticTexts[AccIDs.EditEntryOverlay.totalText.rawValue].firstMatch
	private lazy var totalTextField = editEntryMainView.textFields[AccIDs.EditEntryOverlay.totalTextfield.rawValue].firstMatch
	private lazy var priceText = editEntryMainView.staticTexts[AccIDs.EditEntryOverlay.priceText.rawValue].firstMatch
	private lazy var priceTextField = editEntryMainView.textFields[AccIDs.EditEntryOverlay.priceTextfield.rawValue].firstMatch
	private lazy var volumeText = editEntryMainView.staticTexts[AccIDs.EditEntryOverlay.volumeText.rawValue].firstMatch
	private lazy var volumeTextField = editEntryMainView.textFields[AccIDs.EditEntryOverlay.volumeTextfield.rawValue].firstMatch
	private lazy var tankFilledToggle = editEntryMainView.switches[AccIDs.EditEntryOverlay.tankFilledToggle.rawValue].firstMatch
	
	// MARK: - Dynamic Screen Element
	// Elements that may appear conditionally, such as alerts.
	
	private lazy var alert = app.alerts.firstMatch
	private lazy var okAlertButton = alert.buttons[AccIDs.EditEntryOverlay.okAlertButton.rawValue].firstMatch
	private lazy var cancelAlertButton = alert.buttons[AccIDs.EditEntryOverlay.cancelAlertButton.rawValue].firstMatch
	
	// MARK: - Strings
	
	/// Failure message suffix used in assertion error messages.
	private let failureMessageAddOn = "'Edit entry' overlay"
	
	/// Initializes the screen object and verifies that the Edit Entry overlay is displayed.
	init() {
		assertScreenIsDisplayed()
	}
	
	/// Verifies that the Edit Entry overlay is currently displayed by checking for the presence of the navigation title.
	internal func assertScreenIsDisplayed() {
		runActivity(.screen, "Then verify \(failureMessageAddOn) is loaded") {
			XCTAssert(navigationBarText.wait(for: .long),
					  "\(err) \(failureMessageAddOn) is NOT displayed because 'Entry details' title is NOT displayed")
		}
	}
	
	// MARK: - Navigation & UI Interactions
	
	/// Taps the Cancel button in the navigation bar.
	@discardableResult
	func tapCancelButton() -> Self {
		runActivity(.step, "Then tap 'Cancel' navigation bar button") {
			cancelAlertButton.tapElement()
		}
		return self
	}
	
	/// Taps the Save Entry button in the navigation bar.
	@discardableResult
	func tapSaveEntryButton() -> Self {
		runActivity(.step, "Then tap 'Save entry' navigation bar button") {
			saveEntryButton.tapElement()
		}
		return self
	}
	
	/// Taps the OK button on the alert dialog if displayed.
	@discardableResult
	func tapAlertOkButton() -> Self {
		runActivity(.step, "Then tap 'OK' alert button") {
			okAlertButton.tapElement()
		}
		return self
	}
	
	/// Taps the Cancel button on the alert dialog if displayed.
	@discardableResult
	func tapAlertCancelButton() -> Self {
		runActivity(.step, "Then tap 'Cancel' alert button") {
			cancelAlertButton.tapElement()
		}
		return self
	}
	
	/// Toggles the "Tank Filled" switch.
	@discardableResult
	func tapOnTankFilledToggle() -> Self {
		runActivity(.step, "Then tap 'Tank Filled' toggle") {
			tankFilledToggle.tapElement()
		}
		return self
	}
	
	/// Fills in the text fields with the provided odometer, total, price, and volume values.
	@discardableResult
	func typeInAllFields(odometer: String, total: String, price: String, volume: String) -> Self {
		runActivity(.step, "Then type in data to each text fields") {
			odometerTextField.typeHere(odometer)
			totalTextField.typeHere(total)
			priceTextField.typeHere(price)
		}
		return self
	}
	
	// MARK: - Assertions
	
	/// Verifies the presence and correct labels of all static elements on the overlay.
	@discardableResult
	func verifyAllStaticElements() -> Self {
		runActivity(.assert, "Then verify all static elements exist and labels match on \(failureMessageAddOn)") {
			SoftAssert.shared.assert(cancelButton.wait(), "'Cancel' button doesn't exist on \(failureMessageAddOn)")
			SoftAssert.shared.assert(navigationBarText.wait(), "Title text doesn't exist on \(failureMessageAddOn)")
			SoftAssert.shared.assert(saveEntryButton.wait(), "'Save' button doesn't exist on \(failureMessageAddOn)")
			SoftAssert.shared.assert(fillupDatePicker.wait(), "'Fill Up Date' picker doesn't exist on \(failureMessageAddOn)")
			SoftAssert.shared.assert(gasStationNamePicker.wait(), "'Gas Station Name' picker doesn't exist on \(failureMessageAddOn)")
			SoftAssert.shared.assert(odometerText.wait(), "'Odometer' text doesn't exist on \(failureMessageAddOn)")
			SoftAssert.shared.assert(odometerTextField.wait(), "'Odometer' text field doesn't exist on \(failureMessageAddOn)")
			SoftAssert.shared.assert(totalText.wait(), "'Total' text doesn't exist on \(failureMessageAddOn)")
			SoftAssert.shared.assert(totalTextField.wait(), "'Total' text field doesn't exist on \(failureMessageAddOn)")
			SoftAssert.shared.assert(priceText.wait(), "'Price' text doesn't exist on \(failureMessageAddOn)")
			SoftAssert.shared.assert(priceTextField.wait(), "'Price' text field doesn't exist on \(failureMessageAddOn)")
			SoftAssert.shared.assert(volumeText.wait(), "'Volume' text doesn't exist on \(failureMessageAddOn)")
			SoftAssert.shared.assert(volumeTextField.wait(), "'Volume' text field doesn't exist on \(failureMessageAddOn)")
			SoftAssert.shared.assert(tankFilledToggle.wait(), "'Tank filled up?' toggle doesn't exist on \(failureMessageAddOn)")
		}
		return self
	}
	
	/// Verifies whether the alert is displayed or hidden based on the `isDisplayed` parameter.
	@discardableResult
	func verifyAlert(isDisplayed: Bool) -> Self {
		let actionDescription = isDisplayed ? "displayed" : "NOT displayed"
		runActivity(.assert, "Then verify alert is \(actionDescription) on \(failureMessageAddOn)") {
			if isDisplayed {
				SoftAssert.shared.assert(alert.wait(for: .short), "Alert is NOT displayed on \(failureMessageAddOn)")
			} else {
				SoftAssert.shared.assert(alert.wait(result: false, for: .short), "Alert is displayed on \(failureMessageAddOn)")
			}
		}
		return self
	}
}
