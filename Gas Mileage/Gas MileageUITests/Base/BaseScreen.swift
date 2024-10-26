import Foundation
import XCTest

protocol BaseScreen {
	var app: XCUIApplication { get }
	func assertScreenIsDisplayed()
}

extension BaseScreen {
	var app: XCUIApplication {
		XCUIApplication()
	}
	
	var springboard: XCUIApplication {
		return XCUIApplication(bundleIdentifier: UITestConstant.AppBundleIDs.springboard)
	}
	
	var safariApp: XCUIApplication {
		return XCUIApplication(bundleIdentifier: UITestConstant.AppBundleIDs.safari)
	}
	
	var settingsApp: XCUIApplication {
		return XCUIApplication(bundleIdentifier: UITestConstant.AppBundleIDs.settings)
	}
	
	@discardableResult
	func closeAndReopenTheApp() -> Self {
		app.terminate()
		app.launch()
		return self
	}
}
