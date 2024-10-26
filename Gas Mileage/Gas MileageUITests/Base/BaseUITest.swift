import XCTest

class BaseUITest: XCTestCase {
	private typealias Static = BaseUITest
	
	var app = XCUIApplication()
	
	// MARK: Lifecycle
	override class func setUp() {
		super.setUp()
	}
	
	override func setUp() {
		super.setUp()
		continueAfterFailure = false
	}
	
	override func tearDown() {
		super.tearDown()
		app.terminate()
	}
	
	// MARK: Supporting methods
	func launchPPApp() {
		app.launch()
		// TODO: here can be added addUIInterruptionMonitor
	}
}

extension BaseUITest {
	public func backgroundApp() {
		XCUIDevice.shared.press(.home)
	}
	
	private func resetAuthorization(for auths: [XCUIProtectedResource]) {
		auths.forEach { auth in
			app.resetAuthorizationStatus(for: auth)
		}
		app.launch()
	}
	
	public func resetAllAuthorizations() {
		resetAuthorization(for: [.userTracking, .location])
	}
}
