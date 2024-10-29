import Foundation
import XCTest

class EntriesScreen: BaseScreen, TabBarProtocol {
	// MARK: - Static Screen Elements (in order top to the bottom, left to right how they displayed on the screen)
	private lazy var entriesTabView = app.otherElements[AccIDs.EntriesScreen.entriesTabView.rawValue].firstMatch
	private lazy var navigationBarText = app.staticTexts[LocalizedString.string(forKey: "List of entries")].firstMatch
	private lazy var addEntryButton = app.buttons[AccIDs.EntriesScreen.addEntryButton.rawValue].firstMatch
	private lazy var editEntryButton = app.buttons[AccIDs.EntriesScreen.editEntryButton.rawValue].firstMatch
	private lazy var listView = app.collectionViews[AccIDs.EntriesScreen.listView.rawValue].firstMatch
	
	// MARK: - Dynamic Screen Elements
	// This button is visible only in Debug mode and helps to quickly add randomly generated new entry
	private lazy var generateEntryButton = app.buttons[AccIDs.EntriesScreen.generateEntryButton.rawValue].firstMatch
	private lazy var removeImage = app.images["minus.circle.fill"].firstMatch
	private lazy var deleteCellButton = app.buttons[LocalizedString.string(forKey: "Delete")].firstMatch
	
	// MARK: - Strings
	private let failureMessageAddOn = "'Entries Screen'"
	
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
	@discardableResult
	func tapAddEntryButton() -> Self {
		runActivity(.step, "Then tap 'Add entry' navigation bar button") {
			addEntryButton.tapElement()
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
	func deleteFirstEntry() -> Self {
		runActivity(.step, "Then delete first entry in a list") {
			editEntryButton.tapElement()
			removeImage.tapElement()
			deleteCellButton.tapElement()
			editEntryButton.tapElement()
		}
		return self
	}
	
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
		}
		return self
	}
}
