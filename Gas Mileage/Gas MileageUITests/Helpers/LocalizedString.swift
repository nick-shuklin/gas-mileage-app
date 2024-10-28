import Foundation

struct LocalizedString {
	static func string(forKey key: String) -> String {
		let locale = ProcessInfo.processInfo.environment["TEST_LOCALE"] ?? "en_US"
		
		guard let path = Bundle(for: BaseUITest.self).path(forResource: locale, ofType: "strings") else {
			print("Path not found for resource: \(locale)")
			return key
		}
		
		guard let localizedDictionary = NSDictionary(contentsOfFile: path) as? [String: String] else {
			print("Failed to load dictionary from file at path: \(path)")
			return key
		}
		
		return localizedDictionary[key] ?? key
	}
}
