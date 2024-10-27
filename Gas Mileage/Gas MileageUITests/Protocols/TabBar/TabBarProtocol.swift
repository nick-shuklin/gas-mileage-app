import Foundation
import XCTest

protocol TabBarProtocol: TabBarElements {
	func tapMainTabBarButton() -> Self
}

extension TabBarProtocol {
	// MARK: - Navigation & UI Interactions
	@discardableResult
	func tapMainTabBarButton() -> Self {
		runActivity(.step, "Then tap 'Main' tab bar button") {
			mainTabBarButton.tapElement()
		}
		return self
	}
	
	// MARK: - Assertions
	@discardableResult
	func verifyTabBarElements() -> Self {
		runActivity(.assert, "Then verify all Tab Bar buttons exists") {
			XCTAssert(tabBar.wait(),
					  "\(err) 'Tab Bar' doesn't exists")
			XCTAssert(mainTabBarButton.wait(),
					  "\(err) 'Main' button doesn't exists")
			XCTAssert(entriesTabBarButton.wait(),
					  "\(err) 'Entries' button doesn't exists")
			XCTAssert(chartsTabBarButton.wait(),
					  "\(err) 'Charts' button doesn't exists")
			XCTAssert(settingsTabBarButton.wait(),
					  "\(err) 'Settings' button doesn't exists")
		}
		return self
	}
}
