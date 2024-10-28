import Foundation
import XCTest

class EntriesScreen: BaseScreen, TabBarProtocol {
	// MARK: - Static Screen Elements (in order top to the bottom, left to right how they displayed on the screen)
	private lazy var entriesTabView = app.otherElements[AccIDs.EntriesScreen.entriesTabView.rawValue].firstMatch
	private lazy var navigationBarText = app.staticTexts[LocalizedString.string(forKey: "List of entries")].firstMatch
	private lazy var addEntryButton = app.buttons[AccIDs.EntriesScreen.addEntryButton.rawValue].firstMatch
	private lazy var editEntryButton = app.buttons[AccIDs.EntriesScreen.editEntryButton.rawValue].firstMatch
	
	// MARK: - Dynamic Screen Elements
	// This button is visible only in Debug mode and helps to quickly add randomly generated new entry
	private lazy var generateEntryButton = app.buttons[AccIDs.EntriesScreen.generateEntryButton.rawValue].firstMatch
	
	// MARK: - Strings
	private let failureMessageAddOn = "'Entries Screen'"
	private let last10EntriesLabel = LocalizedString.string(forKey: AccIDs.MainScreen.last10EntriesLabel.rawValue)
	
	init() {
		assertScreenIsDisplayed()
	}
	
	internal func assertScreenIsDisplayed() {
		runActivity(.screen, "Then verify \(failureMessageAddOn) is loaded") {
			XCTAssert(entriesTabView.wait(for: .long),
					  "\(err) \(failureMessageAddOn) is NOT displayed because 'Entries Tab View' is NOT displayed")
		}
	}
	
	// MARK: - Navigation & UI Interactions
	
	// MARK: - Assertions
	@discardableResult
	func verifyAllStaticElements() -> Self {
		runActivity(.assert, "Then verify all static elements exists and labels match on \(failureMessageAddOn)") {
			SoftAssert.shared.assert(navigationBarText.wait(),
					  "\(err) 'List of entries' text doesn't exists on \(failureMessageAddOn)")
			SoftAssert.shared.assert(addEntryButton.wait(),
					  "\(err) 'Add entry' button doesn't exists on \(failureMessageAddOn)")
			SoftAssert.shared.assert(editEntryButton.wait(),
					  "\(err) 'Edit entry' button doesn't exists on \(failureMessageAddOn)")
//			SoftAssert.shared.assert(last10EntriesText.wait(),
//					  "\(err) '\(last10EntriesLabel)' text doesn't exists on \(failureMessageAddOn)")
			
//			SoftAssert.shared.assertEqual(last10EntriesText.label, last10EntriesLabel,
//					  "\(err) label does NOT match on \(failureMessageAddOn)")
		}
		return self
	}
	
	// MARK: - Helper methods
}
