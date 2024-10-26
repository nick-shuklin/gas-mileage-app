import Foundation
import XCTest

protocol BaseScreen {
	var app: XCUIApplication { get }
	func assertScreenIsDisplayed()
}

extension BaseScreen {
	
	// MARK: - Apps
	var app: XCUIApplication {
		XCUIApplication()
	}
	
	var springboard: XCUIApplication {
		return XCUIApplication(bundleIdentifier: AppBundleIDs.springboard)
	}
	
	var safariApp: XCUIApplication {
		return XCUIApplication(bundleIdentifier: AppBundleIDs.safari)
	}
	
	var settingsApp: XCUIApplication {
		return XCUIApplication(bundleIdentifier: AppBundleIDs.settings)
	}
	
	var err: String {
		return Icons.error.rawValue
	}
	
	func runActivity(_ icon: Icons, _ named: String, block: () -> Void) {
		XCTContext.runActivity(named: "\(icon.rawValue) \(named)", block: {_ in
			block()
		})
	}
	
	@discardableResult
	func closeAndReopenTheApp() -> Self {
		app.terminate()
		app.launch()
		return self
	}
}
