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
			XCTAssert(mainTabBarButton.wait(state: .selected),
					  "\(err) 'Main' tab bar button is NOT selected")
		}
		return self
	}
		
	@discardableResult
	func tapEntriesTabBarButton() -> Self {
		runActivity(.step, "Then tap 'Entries' tab bar button") {
			entriesTabBarButton.tapElement()
			XCTAssert(entriesTabBarButton.wait(state: .selected),
					  "\(err) 'Entries' tab bar button is NOT selected")
		}
		return self
	}
	
	@discardableResult
	func tapChartsTabBarButton() -> Self {
		runActivity(.step, "Then tap 'Charts' tab bar button") {
			chartsTabBarButton.tapElement()
			XCTAssert(chartsTabBarButton.wait(state: .selected),
					  "\(err) 'Charts' tab bar button is NOT selected")
		}
		return self
	}
	
	@discardableResult
	func tapSettingsTabBarButton() -> Self {
		runActivity(.step, "Then tap 'Settings' tab bar button") {
			settingsTabBarButton.tapElement()
			XCTAssert(settingsTabBarButton.wait(state: .selected),
					  "\(err) 'Settings' tab bar button is NOT selected")
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
