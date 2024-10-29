import Foundation
import XCTest

class MainScreen: BaseScreen, TabBarProtocol {
	// MARK: - Static Screen Elements (in order top to the bottom, left to right how they displayed on the screen)
	private lazy var mainTabView = app.otherElements[AccIDs.MainScreen.mainTabView.rawValue].firstMatch
	private lazy var navigationBarText = app.staticTexts[LocalizedString.string(forKey: "Main Screen")].firstMatch
	private lazy var chartView = mainTabView.otherElements[AccIDs.MainScreen.chartView.rawValue].firstMatch
	private lazy var last10EntriesScrollView = mainTabView.scrollViews[AccIDs.MainScreen.scrollView.rawValue].firstMatch
	private lazy var last10EntriesText = mainTabView.staticTexts[AccIDs.MainScreen.last10EntriesLabel.rawValue].firstMatch
	
	// MARK: - Strings
	private let failureMessageAddOn = "'Main Screen'"
	private let last10EntriesLabel = LocalizedString.string(forKey: AccIDs.MainScreen.last10EntriesLabel.rawValue)
	
	init() {
		assertScreenIsDisplayed()
	}
	
	internal func assertScreenIsDisplayed() {
		runActivity(.screen, "Then verify \(failureMessageAddOn) is loaded") {
			XCTAssert(mainTabView.wait(for: .long),
					  "\(err) \(failureMessageAddOn) is NOT displayed because 'Main Tab View' is NOT displayed")
		}
	}
	
	// MARK: - Navigation & UI Interactions
	
	// MARK: - Assertions
	@discardableResult
	func verifyAllStaticElements() -> Self {
		runActivity(.assert, "Then verify all static elements exists and labels match on \(failureMessageAddOn)") {
			SoftAssert.shared.assert(navigationBarText.wait(),
					  "'Main Screen' text doesn't exists on \(failureMessageAddOn)")
			SoftAssert.shared.assert(chartView.wait(),
					  "Chart view doesn't exists on \(failureMessageAddOn)")
			SoftAssert.shared.assert(last10EntriesScrollView.wait(),
					  "Scroll view doesn't exists on \(failureMessageAddOn)")
			SoftAssert.shared.assert(last10EntriesText.wait(),
					  "'\(last10EntriesLabel)' text doesn't exists on \(failureMessageAddOn)")
			SoftAssert.shared.assertEqual(last10EntriesText.label, last10EntriesLabel,
					  "label does NOT match on \(failureMessageAddOn)")
		}
		return self
	}
		
	@discardableResult
	func verifyScrollViewEntries() -> Self {
		runActivity(.assert, "Then verify all Scroll View entries on \(failureMessageAddOn)") {
			XCTAssert(last10EntriesScrollView.wait(),
					  "\(err) Scroll view doesn't exists on \(failureMessageAddOn)")
			
			// Access the single child 'Other' view which contains all the rows
			let containerView = last10EntriesScrollView.children(matching: .other).element(boundBy: 0)
			XCTAssert(containerView.wait(), "Container view inside ScrollView should exist.")
			
			// 1. Get all entry rows inside the container view
			let entryRows = containerView.children(matching: .other).allElementsBoundByIndex
			SoftAssert.shared.assert(entryRows.count == 10,
									 "ScrollView should contain exactly 10 entries, but contains \(entryRows.count).")
			
			var previousID: Int?
			for (index, row) in entryRows.enumerated() {
				verifyElementsInEntry(row, at: index)
				
				// 3. Extract ID from the elements and check order
				let currentID = extractID(from: row)
				if let previous = previousID {
					SoftAssert.shared.assert(previous > currentID,
											 "IDs should be in descending order. Previous ID: '\(previous)', Current ID: '\(currentID)'.")
				}
				previousID = currentID
			}
		}
		
		return self
	}
	
	// MARK: - Helper methods
	private func verifyElementsInEntry(_ entry: XCUIElement,
									   at index: Int) {
		let entryID = extractID(from: entry)
		
		let entryLogo = entry.images["short_entry_row_logo_\(entryID)"]
		let creationDateText = entry.staticTexts["short_entry_row_creation_date_\(entryID)"]
		let priceText = entry.staticTexts["short_entry_row_price_\(entryID)"]
		let totalText = entry.staticTexts["short_entry_row_total_\(entryID)"]
		
		SoftAssert.shared.assert(entryLogo.wait(), "Entry '\(index)' should have a logo.")
		SoftAssert.shared.assert(creationDateText.wait(), "Entry '\(index)' should have a creation date text.")
		SoftAssert.shared.assert(priceText.wait(), "Entry '\(index)' should have a price text.")
		SoftAssert.shared.assert(totalText.wait(), "Entry '\(index)' should have a total text.")
		
		SoftAssert.shared.assert(isValidDateFormat(creationDateText.label), "Entry '\(index)' should have a valid date format.")
		SoftAssert.shared.assert(isValidPriceFormat(priceText.label), "Entry '\(index)' should have a valid price format.")
		SoftAssert.shared.assert(isValidTotalFormat(totalText.label), "Entry '\(index)' should have a valid total format.")
	}

	private func extractID(from entry: XCUIElement) -> Int {
		// Extract ID from the first matching element inside the entry containing an ID
		let firstMatchingElement = entry.images.allElementsBoundByIndex.first(where: { $0.identifier.contains("short_entry_row_logo_") })
		guard let identifier = firstMatchingElement?.identifier,
			  let idString = identifier.split(separator: "_").last,
			  let id = Int(idString) else {
			fatalError("Invalid identifier format or ID missing in entry: '\(entry)'")
		}
		return id
	}

	private func isValidDateFormat(_ date: String) -> Bool {
		let dateRegex = #"^\d{1,2}/\d{1,2}/\d{4}$"#
		return NSPredicate(format: "SELF MATCHES %@", dateRegex).evaluate(with: date)
	}

	private func isValidPriceFormat(_ price: String) -> Bool {
		let priceRegex = #"^\$\d+\.\d{2}/gal$"#
		return NSPredicate(format: "SELF MATCHES %@", priceRegex).evaluate(with: price)
	}

	private func isValidTotalFormat(_ total: String) -> Bool {
		let totalRegex = #"^\$\d+\.\d{1,2}$"#
		return NSPredicate(format: "SELF MATCHES %@", totalRegex).evaluate(with: total)
	}
}
