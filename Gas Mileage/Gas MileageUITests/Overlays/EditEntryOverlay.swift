import Foundation
import XCTest

class EditEntryOverlay: BaseScreen {
	// MARK: - Static Screen Elements (in order top to the bottom, left to right how they displayed on the screen)
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
	private lazy var alert = app.alerts.firstMatch
	private lazy var okAlertButton = alert.buttons[AccIDs.EditEntryOverlay.okAlertButton.rawValue].firstMatch
	private lazy var cancelAlertButton = alert.buttons[AccIDs.EditEntryOverlay.cancelAlertButton.rawValue].firstMatch
	
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
			cancelAlertButton.tapElement()
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
	func tapAlertOkButton() -> Self {
		runActivity(.step, "Then tap 'OK' alert button") {
			okAlertButton.tapElement()
		}
		return self
	}
	
	@discardableResult
	func tapAlertCancelButton() -> Self {
		runActivity(.step, "Then tap 'Cancel' alert button") {
			cancelAlertButton.tapElement()
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
	
	@discardableResult
	func typeInAllFields(odometer: String,
						 total: String,
						 price: String,
						 volume: String) -> Self {
		runActivity(.step, "Then type in data to each text fields") {
			odometerTextField.typeHere(odometer)
			totalTextField.typeHere(total)
			priceTextField.typeHere(price)
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
	
	@discardableResult
	func verifyAlert(isDisplayed: Bool) -> Self {
		let actionDescription = isDisplayed ? "NOT displayed" : "displayed"
		runActivity(.assert, "Then verify alert is \(actionDescription) on \(failureMessageAddOn)") {
			if isDisplayed {
				SoftAssert.shared.assert(alert.wait(for: .short), "Alert is \(actionDescription) on \(failureMessageAddOn)")
			} else {
				SoftAssert.shared.assert(alert.wait(result: false, for: .short), "Alert is \(actionDescription) on \(failureMessageAddOn)")
			}
		}
		return self
	}
}
