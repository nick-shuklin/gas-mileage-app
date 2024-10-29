import Foundation
import XCTest

class EntriesScreen: BaseScreen, TabBarProtocol {
	// MARK: - Static Screen Elements (in order top to the bottom, left to right how they displayed on the screen)
	private lazy var entriesTabView = app.otherElements[AccIDs.EntriesScreen.entriesTabView.rawValue].firstMatch
	private lazy var navigationBarText = app.staticTexts[LocalizedString.string(forKey: "List of entries")].firstMatch
	private lazy var addEntryButton = app.buttons[AccIDs.EntriesScreen.addEntryButton.rawValue].firstMatch
	private lazy var editEntryButton = app.buttons[AccIDs.EntriesScreen.editEntryButton.rawValue].firstMatch
	private lazy var listView = app.collectionViews[AccIDs.EntriesScreen.listView.rawValue].firstMatch
	private var entryNavigationLinks: [XCUIElement?] {
		let predicate = NSPredicate(format: "identifier CONTAINS[c] %@", AccIDs.EntriesScreen.entryLinkPrefix.rawValue)
		return app.buttons.matching(predicate).allElementsBoundByIndex
	}
	private var activeLocale: String {
		return ProcessInfo.processInfo.environment["TEST_LOCALE"] ?? "en_US"
	}
	
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
	func tapFirstEntryButton() -> Self {
		runActivity(.step, "Then tap on first entry") {
			XCTAssert(entryNavigationLinks.count > 0, "There are no entries to tap on")
			let element = entryNavigationLinks.first
			element??.tapElement()
		}
		return self
	}
	
	@discardableResult
	func deleteFirstEntry(_ id: inout String) -> Self {
		runActivity(.step, "Then delete first entry in a list") {
			var odometerReading = ""
			let firstCell = app.cells.firstMatch
			let logoElement = firstCell.images.matching(NSPredicate(format: "identifier BEGINSWITH %@", AccIDs.EntriesScreen.entryLogoPrefix.rawValue)).firstMatch
			SoftAssert.shared.assert(logoElement.wait(), "Logo image not found in the first cell")

			if let identifier = logoElement.identifier.split(separator: "_").last {
				odometerReading = String(identifier)
				id = odometerReading
			} else {
				XCTFail("Failed to extract odometer value from the identifier")
			}
			
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
									 "'List of entries' text doesn't exists on \(failureMessageAddOn)")
			SoftAssert.shared.assert(addEntryButton.wait(),
									 "'Add entry' button doesn't exists on \(failureMessageAddOn)")
			SoftAssert.shared.assert(editEntryButton.wait(),
									 "'Edit entry' button doesn't exists on \(failureMessageAddOn)")
		}
		return self
	}
	
	@discardableResult
	func verifyEntryIsDeleted(odometerValue: String) -> Self {
		runActivity(.step, "Then verify entry with odometer '\(odometerValue)' is not displayed") {
			let image = app.images.containing(NSPredicate(format: "identifier CONTAINS %@", odometerValue)).firstMatch
			SoftAssert.shared.assert(image.wait(result: false),
									 "Entry with odometer \(odometerValue) is still visible after deletion")
		}
		return self
	}
	
	@discardableResult
	func verifyAllEntries() -> Self {
		runActivity(.assert, "Then verify all Collection View entries on \(failureMessageAddOn)") {
			XCTAssertTrue(listView.wait(), "Collection view with identifier 'list_view' does not exist")
			
			let cells = listView.cells.allElementsBoundByIndex
			XCTAssertFalse(cells.isEmpty, "No cells found in the collection view")
			
			for cell in cells {
				verifyEntryCell(cell)
			}
		}
		return self
	}
	
	// MARK: - Helper methods
	private var dateFormatter: DateFormatter {
		let formatter = DateFormatter()
		formatter.locale = Locale(identifier: activeLocale)
		formatter.dateFormat = activeLocale == "en_US" ? "MMM d, yyyy" : "d MMM yyyy г."
		return formatter
	}
	
	private var currencyFormatter: NumberFormatter {
		let formatter = NumberFormatter()
		formatter.numberStyle = .currency
		formatter.locale = Locale(identifier: activeLocale)
		return formatter
	}
	
	private func verifyEntryCell(_ cell: XCUIElement) {
		let navigationLink = cell.buttons.matching(NSPredicate(format: "identifier BEGINSWITH %@", AccIDs.EntriesScreen.entryLinkPrefix.rawValue)).firstMatch
		SoftAssert.shared.assert(navigationLink.wait(), "Navigation link button not found in cell")
		
		let logoImage = cell.images.matching(NSPredicate(format: "identifier BEGINSWITH %@", AccIDs.EntriesScreen.entryLogoPrefix.rawValue)).firstMatch
		SoftAssert.shared.assert(logoImage.wait(), "Logo image not found in cell")
		
		let dateLabel = cell.staticTexts.matching(NSPredicate(format: "identifier BEGINSWITH %@", AccIDs.EntriesScreen.entryFillupDatePrefix.rawValue)).firstMatch
		SoftAssert.shared.assert(dateLabel.wait(), "Date label not found in cell")
		verifyDateFormat(dateLabel.label)
		
		let odometerLabel = cell.staticTexts.matching(NSPredicate(format: "identifier BEGINSWITH %@", AccIDs.EntriesScreen.entryOdometerPrefix.rawValue)).firstMatch
		SoftAssert.shared.assert(odometerLabel.wait(), "Odometer label not found in cell")
		verifyOdometerFormat(odometerLabel.label)
		
		let gasPriceLabel = cell.staticTexts.matching(NSPredicate(format: "identifier BEGINSWITH %@", AccIDs.EntriesScreen.entryGasPricePrefix.rawValue)).firstMatch
		SoftAssert.shared.assert(gasPriceLabel.wait(), "Gas price label not found in cell")
		verifyCurrencyFormat(gasPriceLabel.label)
		
		let totalLabel = cell.staticTexts.matching(NSPredicate(format: "identifier BEGINSWITH %@", AccIDs.EntriesScreen.entryTotalPrefix.rawValue)).firstMatch
		SoftAssert.shared.assert(totalLabel.wait(), "Total label not found in cell")
		verifyCurrencyFormat(totalLabel.label)
		
		let mileageLabel = cell.staticTexts.matching(NSPredicate(format: "identifier BEGINSWITH %@", AccIDs.EntriesScreen.entryGasMileagePrefix.rawValue)).firstMatch
		SoftAssert.shared.assert(mileageLabel.wait(), "Gas mileage label not found in cell")
		verifyMileageFormat(mileageLabel.label)
		
		let volumeLabel = cell.staticTexts.matching(NSPredicate(format: "identifier BEGINSWITH %@", AccIDs.EntriesScreen.entryVolumePrefix.rawValue)).firstMatch
		SoftAssert.shared.assert(volumeLabel.wait(), "Volume label not found in cell")
		verifyVolumeFormat(volumeLabel.label)
	}

	private func verifyDateFormat(_ dateText: String) {
		guard let _ = dateFormatter.date(from: dateText) else {
			SoftAssert.shared.softFail("Date format is incorrect: \(dateText)")
			return
		}
	}

	private func verifyCurrencyFormat(_ currencyText: String) {
		let pattern: String
		if activeLocale == "en_US" {
			   // Pattern for "en_US" with or without "per gal" and optional commas in thousands place
			   pattern = #"^\$\d{1,3}(,\d{3})*(\.\d{1,2})?( per gal)?$"#
		   } else {
			   // Pattern for Russian locale to match currency values with optional "per gal"
			   pattern = #"^\$\d+(\.\d{1,2})?( per gal)?$"#
		   }
		validateTextWithRegex(pattern, text: currencyText, failureMessage: "Currency format is incorrect: \(currencyText)")
	}

	private func verifyOdometerFormat(_ odometerText: String) {
		let pattern: String
		if activeLocale == "en_US" {
			pattern = #"^[\d,]+ miles$"#
		} else {
			pattern = #"^[\d\s,]+ миль$"#
		}
		validateTextWithRegex(pattern, text: odometerText, failureMessage: "Odometer format is incorrect: \(odometerText)")
	}

	private func verifyMileageFormat(_ mileageText: String) {
		let pattern = activeLocale == "en_US" ? #"^[\d.]+ mpg$"# : #"^[\d.]+ mpg$"#
		validateTextWithRegex(pattern, text: mileageText, failureMessage: "Mileage format is incorrect: \(mileageText)")
	}

	private func verifyVolumeFormat(_ volumeText: String) {
		let pattern = activeLocale == "en_US" ? #"^[\d.]+ gal$"# : #"^[\d.]+ gal$"#
		validateTextWithRegex(pattern, text: volumeText, failureMessage: "Volume format is incorrect: \(volumeText)")
	}
	
	private func validateTextWithRegex(_ pattern: String,
									   text: String,
									   failureMessage: String) {
		let regex = try! NSRegularExpression(pattern: pattern, options: [])
		let range = NSRange(location: 0, length: text.utf16.count)
		if regex.firstMatch(in: text, options: [], range: range) == nil {
			SoftAssert.shared.softFail(failureMessage)
		}
	}
}
