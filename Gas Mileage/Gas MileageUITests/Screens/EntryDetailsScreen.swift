import Foundation
import XCTest

class EntryDetailsScreen: BaseScreen {
	// MARK: - Static Screen Elements (in order top to the bottom, left to right how they displayed on the screen)
	private lazy var backButton = app.buttons[LocalizedString.string(forKey: "List of entries")].firstMatch
	private lazy var navigationBarText = app.staticTexts[LocalizedString.string(forKey: "Entry details")].firstMatch
	private lazy var editEntryButton = app.buttons[AccIDs.EntriesScreen.editEntryButton.rawValue].firstMatch
	private lazy var listView = app.collectionViews[AccIDs.EntriesScreen.listView.rawValue].firstMatch
	private lazy var fillupDateText = app.staticTexts[AccIDs.EntryDetailsView.fillupDateText.rawValue].firstMatch
	private lazy var gasStationNameText = app.staticTexts[AccIDs.EntryDetailsView.gasStationNameText.rawValue].firstMatch
	private var odometerText: XCUIElement? {
		let predicate = NSPredicate(format: "identifier CONTAINS[c] %@", AccIDs.EntryDetailsView.odometer.rawValue)
		return app.staticTexts.matching(predicate).allElementsBoundByIndex.first
	}
	private var odometerData: XCUIElement? {
		let predicate = NSPredicate(format: "identifier CONTAINS[c] %@", AccIDs.EntryDetailsView.odometer.rawValue)
		return app.staticTexts.matching(predicate).allElementsBoundByIndex.last
	}
	private var totalText: XCUIElement? {
		let predicate = NSPredicate(format: "identifier CONTAINS[c] %@", AccIDs.EntryDetailsView.total.rawValue)
		return app.staticTexts.matching(predicate).allElementsBoundByIndex.first
	}
	private var totalData: XCUIElement? {
		let predicate = NSPredicate(format: "identifier CONTAINS[c] %@", AccIDs.EntryDetailsView.total.rawValue)
		return app.staticTexts.matching(predicate).allElementsBoundByIndex.last
	}
	private var priceText: XCUIElement? {
		let predicate = NSPredicate(format: "identifier CONTAINS[c] %@", AccIDs.EntryDetailsView.price.rawValue)
		return app.staticTexts.matching(predicate).allElementsBoundByIndex.first
	}
	private var priceData: XCUIElement? {
		let predicate = NSPredicate(format: "identifier CONTAINS[c] %@", AccIDs.EntryDetailsView.price.rawValue)
		return app.staticTexts.matching(predicate).allElementsBoundByIndex.last
	}
	private var volumeText: XCUIElement? {
		let predicate = NSPredicate(format: "identifier CONTAINS[c] %@", AccIDs.EntryDetailsView.volume.rawValue)
		return app.staticTexts.matching(predicate).allElementsBoundByIndex.first
	}
	private var volumeData: XCUIElement? {
		let predicate = NSPredicate(format: "identifier CONTAINS[c] %@", AccIDs.EntryDetailsView.volume.rawValue)
		return app.staticTexts.matching(predicate).allElementsBoundByIndex.last
	}
	private var gasMileageText: XCUIElement? {
		let predicate = NSPredicate(format: "identifier CONTAINS[c] %@", AccIDs.EntryDetailsView.gasMileage.rawValue)
		return app.staticTexts.matching(predicate).allElementsBoundByIndex.first
	}
	private var gasMileageData: XCUIElement? {
		let predicate = NSPredicate(format: "identifier CONTAINS[c] %@", AccIDs.EntryDetailsView.gasMileage.rawValue)
		return app.staticTexts.matching(predicate).allElementsBoundByIndex.last
	}
	private lazy var tankFilledToggle = app.switches[AccIDs.EntryDetailsView.tankFilledToggle.rawValue].firstMatch
	
	// MARK: - Dynamic Screen Element
	
	// MARK: - Strings
	private let failureMessageAddOn = "'Entry details screen'"
	private let odometerTextLabel = LocalizedString.string(forKey: AccIDs.EntryDetailsView.odometer.rawValue)
	private let totalTextLabel = LocalizedString.string(forKey: AccIDs.EntryDetailsView.total.rawValue)
	private let priceTextLabel = LocalizedString.string(forKey: AccIDs.EntryDetailsView.price.rawValue)
	private let volumeTextLabel = LocalizedString.string(forKey: AccIDs.EntryDetailsView.volume.rawValue)
	private let gasMileageTextLabel = LocalizedString.string(forKey: AccIDs.EntryDetailsView.gasMileage.rawValue)
	
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
	func tapBackButton() -> Self {
		runActivity(.step, "Then tap 'Back' navigation bar button") {
			backButton.tapElement()
		}
		return self
	}
	
	@discardableResult
	func tapEditEntryButton() -> Self {
		runActivity(.step, "Then tap 'Edit entry' navigation bar button") {
			editEntryButton.tapElement()
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
			SoftAssert.shared.assert(navigationBarText.wait(),
									 "'List of entries' text doesn't exists on \(failureMessageAddOn)")
			SoftAssert.shared.assert(backButton.wait(),
									 "'Back' button doesn't exists on \(failureMessageAddOn)")
			SoftAssert.shared.assert(editEntryButton.wait(),
									 "'Edit entry' button doesn't exists on \(failureMessageAddOn)")
			SoftAssert.shared.assert(listView.wait(),
									 "'Collection' view doesn't exists on \(failureMessageAddOn)")
			SoftAssert.shared.assert(fillupDateText.wait(),
									 "'Fill up date' text doesn't exists on \(failureMessageAddOn)")
			SoftAssert.shared.assert(gasStationNameText.wait(),
									 "Gas station name text doesn't exists on \(failureMessageAddOn)")
			SoftAssert.shared.assert(((odometerText?.wait()) != nil),
									 "'Odometer' text doesn't exists on \(failureMessageAddOn)")
			SoftAssert.shared.assertEqual(odometerText?.label, odometerTextLabel,
					  "label does NOT match on \(failureMessageAddOn)")
			SoftAssert.shared.assert(((odometerData?.wait()) != nil),
									 "'Odometer' data doesn't exists on \(failureMessageAddOn)")
			SoftAssert.shared.assert(((totalText?.wait()) != nil),
									 "'Total' text doesn't exists on \(failureMessageAddOn)")
			SoftAssert.shared.assertEqual(totalText?.label, totalTextLabel,
					  "label does NOT match on \(failureMessageAddOn)")
			SoftAssert.shared.assert(((totalData?.wait()) != nil),
									 "'Total' data doesn't exists on \(failureMessageAddOn)")
			SoftAssert.shared.assert(((priceText?.wait()) != nil),
									 "'Price' text doesn't exists on \(failureMessageAddOn)")
			SoftAssert.shared.assertEqual(priceText?.label, priceTextLabel,
					  "label does NOT match on \(failureMessageAddOn)")
			SoftAssert.shared.assert(((priceData?.wait()) != nil),
									 "'Price' data doesn't exists on \(failureMessageAddOn)")
			SoftAssert.shared.assert(((volumeText?.wait()) != nil),
									 "'Volume' text doesn't exists on \(failureMessageAddOn)")
			SoftAssert.shared.assertEqual(volumeText?.label, volumeTextLabel,
					  "label does NOT match on \(failureMessageAddOn)")
			SoftAssert.shared.assert(((volumeData?.wait()) != nil),
									 "'Volume' data doesn't exists on \(failureMessageAddOn)")
			SoftAssert.shared.assert(((gasMileageText?.wait()) != nil),
									 "'Gas mileage' text doesn't exists on \(failureMessageAddOn)")
			SoftAssert.shared.assertEqual(gasMileageText?.label, gasMileageTextLabel,
					  "label does NOT match on \(failureMessageAddOn)")
			SoftAssert.shared.assert(((gasMileageData?.wait()) != nil),
									 "'Gas mileage' data doesn't exists on \(failureMessageAddOn)")
			SoftAssert.shared.assert(tankFilledToggle.wait(),
									 "'Tank filled up?' toggle doesn't exists on \(failureMessageAddOn)")
		}
		return self
	}
}
