import Foundation

enum UITestConstant {
	enum AppBundleIDs {
		static let springboard = "com.apple.springboard"
		static let safari = "com.apple.mobilesafari"
		static let settings = "com.apple.Preferences"
	}
	
	enum Timeouts {
		static let veryShort: TimeInterval = 1
		static let short: TimeInterval = 3
		static let medium: TimeInterval = 5
		static let long: TimeInterval = 7
		static let veryLong: TimeInterval = 20
	}
}
