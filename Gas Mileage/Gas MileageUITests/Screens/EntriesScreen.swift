import Foundation
import XCTest

class EntriesScreen: BaseScreen, TabBarProtocol {
	// MARK: - Static Screen Elements (in order top to the bottom, left to right how they displayed on the screen)
	private lazy var entriesTabView = app.otherElements[AccIDs.EntriesScreen.entriesTabView.rawValue].firstMatch
	
	
	
	
	
	
	
	
	private lazy var mainScreenNavigationBarText = app.staticTexts[LocalizedString.string(forKey: "Main Screen")].firstMatch
	private lazy var chartView = mainTabView.otherElements[AccIDs.MainScreen.chartView.rawValue].firstMatch
	private lazy var last10EntriesScrollView = mainTabView.scrollViews[AccIDs.MainScreen.scrollView.rawValue].firstMatch
	private lazy var last10EntriesText = mainTabView.staticTexts[AccIDs.MainScreen.last10EntriesLabel.rawValue].firstMatch
	
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
			SoftAssert.shared.assert(mainScreenNavigationBarText.wait(),
					  "\(err) 'Main Screen' text doesn't exists on \(failureMessageAddOn)")
			SoftAssert.shared.assert(chartView.wait(),
					  "\(err) Chart view doesn't exists on \(failureMessageAddOn)")
			SoftAssert.shared.assert(last10EntriesScrollView.wait(),
					  "\(err) Scroll view doesn't exists on \(failureMessageAddOn)")
			SoftAssert.shared.assert(last10EntriesText.wait(),
					  "\(err) '\(last10EntriesLabel)' text doesn't exists on \(failureMessageAddOn)")
			SoftAssert.shared.assertEqual(last10EntriesText.label, last10EntriesLabel,
					  "\(err) label does NOT match on \(failureMessageAddOn)")
		}
		return self
	}
	
	// MARK: - Helper methods
}
