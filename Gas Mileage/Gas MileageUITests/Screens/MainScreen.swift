import Foundation
import XCTest

class MainScreen: BaseScreen, TabBarProtocol {
	// MARK: - Static Screen Elements (in order top to the bottom, left to right as displayed on the screen)
	private lazy var mainTabView = app.otherElements[AccIDs.MainScreen.mainTabView.rawValue].firstMatch
	private lazy var navigationBarText = app.staticTexts[LocalizedString.string(forKey: "Main Screen")].firstMatch
	private lazy var chartView = mainTabView.otherElements[AccIDs.MainScreen.chartView.rawValue].firstMatch
	private lazy var last10EntriesScrollView = mainTabView.scrollViews[AccIDs.MainScreen.scrollView.rawValue].firstMatch
	private lazy var last10EntriesText = mainTabView.staticTexts[AccIDs.MainScreen.last10EntriesLabel.rawValue].firstMatch

	// MARK: - Strings
	private let failureMessageAddOn = "'Main Screen'"
	private let last10EntriesLabel = LocalizedString.string(forKey: AccIDs.MainScreen.last10EntriesLabel.rawValue)

	// MARK: - Initialization
	/// Initializes and verifies that the Main Screen is displayed.
	init() {
		assertScreenIsDisplayed()
	}
	
	/// Checks that the Main Screen is fully loaded by verifying a key element.
	internal func assertScreenIsDisplayed() {
		runActivity(.screen, "Then verify \(failureMessageAddOn) is loaded") {
			XCTAssert(mainTabView.wait(for: .long),
					  "\(err) \(failureMessageAddOn) is NOT displayed because 'Main Tab View' is NOT displayed")
		}
	}
	
	// MARK: - Assertions
	/// Verifies that all main static elements on the screen are displayed correctly.
	@discardableResult
	func verifyAllStaticElements() -> Self {
		runActivity(.assert, "Then verify all static elements exist and labels match on \(failureMessageAddOn)") {
			SoftAssert.shared.assert(navigationBarText.wait(),
									 "'Main Screen' text doesn't exist on \(failureMessageAddOn)")
			SoftAssert.shared.assert(chartView.wait(),
									 "Chart view doesn't exist on \(failureMessageAddOn)")
			SoftAssert.shared.assert(last10EntriesScrollView.wait(),
									 "Scroll view doesn't exist on \(failureMessageAddOn)")
			SoftAssert.shared.assert(last10EntriesText.wait(),
									 "'\(last10EntriesLabel)' text doesn't exist on \(failureMessageAddOn)")
			SoftAssert.shared.assertEqual(last10EntriesText.label, last10EntriesLabel,
										  "Label does NOT match on \(failureMessageAddOn)")
		}
		return self
	}
	
	/// Verifies that entries in the scroll view meet expected conditions, such as being in descending order.
	@discardableResult
	func verifyScrollViewEntries() -> Self {
		runActivity(.assert, "Then verify all Scroll View entries on \(failureMessageAddOn)") {
			XCTAssert(last10EntriesScrollView.wait(),
					  "\(err) Scroll view doesn't exist on \(failureMessageAddOn)")
			
			let containerView = last10EntriesScrollView.children(matching: .other).element(boundBy: 0)
			XCTAssert(containerView.wait(),"Container view inside ScrollView should exist.")
			
			let entryRows = containerView.children(matching: .other).allElementsBoundByIndex
			SoftAssert.shared.assert(entryRows.count == 10,
									 "ScrollView should contain exactly 10 entries, but contains \(entryRows.count).")
			
			var previousID: Int?
			for (index, row) in entryRows.enumerated() {
				verifyElementsInEntry(row, at: index)
				
				let currentID = extractID(from: row)
				if let previous = previousID {
					SoftAssert.shared.assert(previous > currentID,"IDs should be in descending order. Previous ID: '\(previous)', Current ID: '\(currentID)'.")
				}
				previousID = currentID
			}
		}
		
		return self
	}
	
	// MARK: - Helper methods
	/// Verifies that all expected elements are present within an entry row in the ScrollView.
	private func verifyElementsInEntry(_ entry: XCUIElement, at index: Int) {
		let entryID = extractID(from: entry)
		
		let entryLogo = entry.images["short_entry_row_logo_\(entryID)"]
		let creationDateText = entry.staticTexts["short_entry_row_creation_date_\(entryID)"]
		let priceText = entry.staticTexts["short_entry_row_price_\(entryID)"]
		let totalText = entry.staticTexts["short_entry_row_total_\(entryID)"]
		
		SoftAssert.shared.assert(entryLogo.wait(),
								 "Entry '\(index)' should have a logo.")
		SoftAssert.shared.assert(creationDateText.wait(),
								 "Entry '\(index)' should have a creation date text.")
		SoftAssert.shared.assert(priceText.wait(),
								 "Entry '\(index)' should have a price text.")
		SoftAssert.shared.assert(totalText.wait(),
								 "Entry '\(index)' should have a total text.")
		
		SoftAssert.shared.assert(isValidDateFormat(creationDateText.label),
								 "Entry '\(index)' should have a valid date format.")
		SoftAssert.shared.assert(isValidPriceFormat(priceText.label),
								 "Entry '\(index)' should have a valid price format.")
		SoftAssert.shared.assert(isValidTotalFormat(totalText.label),
								 "Entry '\(index)' should have a valid total format.")
	}

	/// Extracts the entry ID from an entry element's identifier.
	private func extractID(from entry: XCUIElement) -> Int {
		let firstMatchingElement = entry.images.allElementsBoundByIndex.first(where: { $0.identifier.contains("short_entry_row_logo_") })
		guard let identifier = firstMatchingElement?.identifier,
			  let idString = identifier.split(separator: "_").last,
			  let id = Int(idString) else {
			fatalError("Invalid identifier format or ID missing in entry: '\(entry)'")
		}
		return id
	}

	/// Validates that the date format matches the expected pattern.
	private func isValidDateFormat(_ date: String) -> Bool {
		let dateRegex = #"^\d{1,2}/\d{1,2}/\d{4}$"#
		return NSPredicate(format: "SELF MATCHES %@", dateRegex).evaluate(with: date)
	}

	/// Validates that the price format matches the expected pattern.
	private func isValidPriceFormat(_ price: String) -> Bool {
		let priceRegex = #"^\$\d+\.\d{2}/gal$"#
		return NSPredicate(format: "SELF MATCHES %@", priceRegex).evaluate(with: price)
	}

	/// Validates that the total format matches the expected pattern.
	private func isValidTotalFormat(_ total: String) -> Bool {
		let totalRegex = #"^\$\d+\.\d{1,2}$"#
		return NSPredicate(format: "SELF MATCHES %@", totalRegex).evaluate(with: total)
	}
}
