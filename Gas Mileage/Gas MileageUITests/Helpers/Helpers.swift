import Foundation
import XCTest

class Helpers: BaseUITest, BaseScreen {
	internal func assertScreenIsDisplayed() {}
	
	@discardableResult
	func waitForApplicationToLaunch() -> Self {
		launchPPApp()
		runActivity(.step, "Waiting for the App to be in foreground state") {
			XCTAssert(app.wait(for: .runningForeground, timeout: UITestConstant.Timeouts.medium),
					  "\(err) App is not in foreground state")
		}
		
		return self
	}
}
