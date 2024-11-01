import Foundation
import XCTest

class EntriesScreen: BaseScreen, TabBarProtocol {
	// MARK: - Static Screen Elements (in order top to the bottom, left to right as displayed on the screen)
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
	// Element available only in Debug mode for quick test setup.
	private lazy var generateEntryButton = app.buttons[AccIDs.EntriesScreen.generateEntryButton.rawValue].firstMatch
	private lazy var removeImage = app.images["minus.circle.fill"].firstMatch
	private lazy var deleteCellButton = app.buttons[LocalizedString.string(forKey: "Delete")].firstMatch
	
	// MARK: - Strings
	private let failureMessageAddOn = "'Entries Screen'"
	
	// MARK: - Initialization
	/// Initializes and verifies that the Entries screen is displayed.
	@discardableResult
	init() {
		assertScreenIsDisplayed()
	}
	
	/// Ensures the Entries screen is loaded by checking key UI elements.
	internal func assertScreenIsDisplayed() {
		runActivity(.screen, "Then verify \(failureMessageAddOn) is loaded") {
			XCTAssert(entriesTabView.wait(for: .long),
					  "\(err) \(failureMessageAddOn) is NOT displayed because 'Entries Tab View' is NOT displayed")
			XCTAssert(addEntryButton.wait(for: .short),
					  "\(err) \(failureMessageAddOn) is NOT displayed because 'Add entry' button is NOT displayed")
			XCTAssert(addEntryButton.wait(state: .hittable, for: .short),
					  "\(err) \(failureMessageAddOn) is NOT displayed because 'Add entry' button is NOT hittable")
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
			entryNavigationLinks.first??.tapElement()
		}
		return self
	}
	
	/// Deletes the first entry in the list and captures its odometer reading.
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
	
	/// Deletes the first entry and assigns its odometer reading through a closure, if provided.
	@discardableResult
	func deleteFirstEntry(assignValue: ((String) -> Void)? = nil) -> Self {
		runActivity(.step, "Then delete first entry in a list") {
			guard app.cells.firstMatch.exists else {
				print("No entries available to delete")
				return
			}

			var odometerReading = ""
			let firstCell = app.cells.firstMatch
			let logoElement = firstCell.images.matching(NSPredicate(format: "identifier BEGINSWITH %@", AccIDs.EntriesScreen.entryLogoPrefix.rawValue)).firstMatch
			SoftAssert.shared.assert(logoElement.wait(), "Logo image not found in the first cell")

			if let identifier = logoElement.identifier.split(separator: "_").last {
				odometerReading = String(identifier)
				assignValue?(odometerReading)
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
	/// Verifies that all static elements exist on the Entries screen.
	@discardableResult
	func verifyAllStaticElements() -> Self {
		runActivity(.assert, "Then verify all static elements exist and labels match on \(failureMessageAddOn)") {
			SoftAssert.shared.assert(navigationBarText.wait(),
									 "'List of entries' text doesn't exist on \(failureMessageAddOn)")
			SoftAssert.shared.assert(addEntryButton.wait(),
									 "'Add entry' button doesn't exist on \(failureMessageAddOn)")
			SoftAssert.shared.assert(editEntryButton.wait(),
									 "'Edit entry' button doesn't exist on \(failureMessageAddOn)")
		}
		return self
	}
	
	/// Checks if an entry with the specified odometer value is displayed or hidden.
	@discardableResult
	func verifyEntry(isDisplayed: Bool,
					 odometerValue: String) -> Self {
		let actionDescription = isDisplayed ? "not displayed" : "displayed"
		runActivity(.step, "Then verify entry with odometer '\(odometerValue)' is \(actionDescription)") {
			let image = app.images.containing(NSPredicate(format: "identifier CONTAINS %@", odometerValue)).firstMatch
			
			if isDisplayed {
				SoftAssert.shared.assert(image.wait(for: .short), "Entry with odometer '\(odometerValue)' is not visible as expected")
			} else {
				SoftAssert.shared.assert(image.wait(result: false, for: .short), "Entry with odometer '\(odometerValue)' is still visible")
			}
		}
		return self
	}
	
	/// Confirms that all entries in the collection view are displayed correctly.
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
	/// Retrieves the odometer reading from the first entry and assigns it to the provided variable.
	func getOdometerFromFirstEntry(_ odometerValue: inout String) -> Self {
		runActivity(.step, "Get the odometer reading from the first entry in the list") {
			guard let firstEntry = entryNavigationLinks.first as? XCUIElement else {
				return odometerValue = String(1)
			}

			if let identifier = firstEntry.identifier.split(separator: "_").last {
				return odometerValue = String(identifier)
			} else {
				XCTFail("Failed to extract odometer reading from the first entry's accessibility identifier")
			}
		}
		return self
	}
	
	// MARK: - Formatters and Validation Methods
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
	
	/// Checks that each field within a cell matches its expected format.
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

	/// Verifies that a date string matches the expected date format for the current locale.
	private func verifyDateFormat(_ dateText: String) {
		guard let _ = dateFormatter.date(from: dateText) else {
			SoftAssert.shared.softFail("Date format is incorrect: \(dateText)")
			return
		}
	}

	/// Validates that a currency string follows the correct format based on locale settings.
	private func verifyCurrencyFormat(_ currencyText: String) {
		let pattern: String
		if activeLocale == "en_US" {
			// Pattern for "en_US" with optional "per gal" suffix and commas in the thousands place
			pattern = #"^\$\d{1,3}(,\d{3})*(\.\d{1,2})?( per gal)?$"#
		} else {
			// Pattern for Russian locale with optional "per gal" suffix
			pattern = #"^\$\d+(\.\d{1,2})?( per gal)?$"#
		}
		verifyTextWithRegex(pattern, text: currencyText, failureMessage: "Currency format is incorrect: \(currencyText)")
	}

	/// Checks if the odometer text follows the expected format, differing by locale.
	private func verifyOdometerFormat(_ odometerText: String) {
		let pattern: String
		if activeLocale == "en_US" {
			pattern = #"^[\d,]+ miles$"#
		} else {
			pattern = #"^[\d\s,]+ миль$"#
		}
		verifyTextWithRegex(pattern, text: odometerText, failureMessage: "Odometer format is incorrect: \(odometerText)")
	}

	/// Ensures mileage text follows the correct format depending on locale.
	private func verifyMileageFormat(_ mileageText: String) {
		let pattern = activeLocale == "en_US" ? #"^[\d.]+ mpg$"# : #"^[\d.]+ mpg$"#
		verifyTextWithRegex(pattern, text: mileageText, failureMessage: "Mileage format is incorrect: \(mileageText)")
	}

	/// Validates that the volume text matches the expected format based on locale.
	private func verifyVolumeFormat(_ volumeText: String) {
		let pattern = activeLocale == "en_US" ? #"^[\d.]+ gal$"# : #"^[\d.]+ gal$"#
		verifyTextWithRegex(pattern, text: volumeText, failureMessage: "Volume format is incorrect: \(volumeText)")
	}
	
	/// Confirms that a given text matches the specified regex pattern, logging failure if it doesn't.
	private func verifyTextWithRegex(_ pattern: String,
									 text: String,
									 failureMessage: String) {
		let regex = try! NSRegularExpression(pattern: pattern, options: [])
		let range = NSRange(location: 0, length: text.utf16.count)
		if regex.firstMatch(in: text, options: [], range: range) == nil {
			SoftAssert.shared.softFail(failureMessage)
		}
	}
}
