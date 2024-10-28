import Foundation
import XCTest

class HomeScreen: BaseScreen, TabBarProtocol {
	// MARK: - Static Screen Elements
	private lazy var mainTabView = app.otherElements["main_tab"].firstMatch
	private lazy var chartView = app.otherElements["ytd_chart_view"].firstMatch
	private lazy var last10EntriesScrollView = app.scrollViews["scroll_view"].firstMatch
	private lazy var last10EntriesLabel = app.staticTexts["last_10_entries_label"].firstMatch
	
	// MARK: - Labels
	private let failureMessageAddOn = "'Home Screen'"
	private let last10EntriesLabelValue = LocalizedString.string(forKey: "last_10_entries_label", locale: "en_US")
	
	init() {
		assertScreenIsDisplayed()
	}
	
	internal func assertScreenIsDisplayed() {
		runActivity(.screen, "Then verify \(failureMessageAddOn) is loaded") {
			XCTAssert(mainTabView.wait(for: .long),
					  "\(err) \(failureMessageAddOn) is NOT displayed because Main Tab is NOT displayed")
		}
	}
	
	// MARK: - Navigation & UI Interactions
	
	// MARK: - Assertions
	@discardableResult
	func verifyAllStaticElements() -> Self {
		runActivity(.assert, "Then verify all static elements") {
			XCTAssert(chartView.wait(),
					  "\(err) Chart view doesn't exists on \(failureMessageAddOn)")
			XCTAssert(last10EntriesScrollView.wait(),
					  "\(err) Scroll view doesn't exists on \(failureMessageAddOn)")
			XCTAssertEqual(last10EntriesLabel.label, last10EntriesLabelValue,
					  "\(err) label does NOT match on \(failureMessageAddOn)")
		}
		return self
	}
}
