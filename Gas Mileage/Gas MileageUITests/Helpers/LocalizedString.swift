import Foundation

/// A utility struct to fetch localized strings from a `.strings` file based on the current locale.
/// This struct retrieves the appropriate localized string by reading a `.strings` file corresponding to the current locale.
/// The locale is determined using an environment variable (`TEST_LOCALE`), which is expected to be set in the test configuration.
///
/// - Note: This struct is specifically designed for localization testing within an XCUITest target.
///         Ensure that the `.strings` files are correctly added to the XCUITest bundle with appropriate locale identifiers.
///
/// Usage example:
/// ```swift
/// let localizedMessage = LocalizedString.string(forKey: "welcome_message_label")
/// XCTAssertEqual(localizedMessage, "Welcome!", "The welcome message should be correctly localized")
/// ```
struct LocalizedString {
	
	/// Fetches a localized string for a given key based on the current locale.
	///
	/// This method retrieves the locale from the environment variable `TEST_LOCALE`, defaulting to `"en_US"` if the variable is not set.
	/// It then attempts to find a corresponding `.strings` file and fetch the localized string for the specified key.
	///
	/// - Parameter key: The key for the localized string, usually matching an accessibility identifier or a label key in the app.
	///
	/// - Returns: The localized string corresponding to the provided key if found. If the key or localization file is not found,
	///            the key itself is returned as a fallback.
	///
	/// - Important: The `.strings` files should be named using the locale identifier (e.g., `"en_US.strings"`, `"fr.strings"`)
	///              and must be added to the XCUITest target's bundle.
	///
	/// - Note: The method prints an error message to the console if the localization file cannot be found or loaded.
	///
	/// - SeeAlso: `ProcessInfo.processInfo.environment` for accessing environment variables in XCUITest.
	///
	/// - Example:
	/// ```swift
	/// let localizedString = LocalizedString.string(forKey: "last_10_entries_label")
	/// ```
	static func string(forKey key: String) -> String {
		// Retrieve the locale from the environment variable, defaulting to "en_US" if not set
		let locale = ProcessInfo.processInfo.environment["TEST_LOCALE"] ?? "en_US"
		
		// Locate the .strings file based on the determined locale
		guard let path = Bundle(for: BaseUITest.self).path(forResource: locale, ofType: "strings") else {
			print("Path not found for resource: \(locale)")
			return key
		}
		
		// Load the localized strings dictionary from the .strings file
		guard let localizedDictionary = NSDictionary(contentsOfFile: path) as? [String: String] else {
			print("Failed to load dictionary from file at path: \(path)")
			return key
		}
		
		// Return the localized string value for the given key, or the key itself if not found
		return localizedDictionary[key] ?? key
	}
}
