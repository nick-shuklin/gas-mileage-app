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
		runActivity(.assert, "Then verify all Tab Bar buttons exists, hittable and labels match") {
			SoftAssert.shared.assert(tabBar.wait(),
					  "'Tab Bar' doesn't exists")
			SoftAssert.shared.assert(mainTabBarButton.wait(),
					  "'Main' button doesn't exists")
			SoftAssert.shared.assert(mainTabBarButton.wait(state: .hittable),
					  "'Main' button is NOT hittable")
			SoftAssert.shared.assertEqual(mainTabBarButton.label,
										  LocalizedString.string(forKey: AccIDs.TabBar.mainTabBarButton.rawValue),
										  "label does NOT match")
			SoftAssert.shared.assert(entriesTabBarButton.wait(),
					  "'Entries' button doesn't exists")
			SoftAssert.shared.assert(entriesTabBarButton.wait(state: .hittable),
					  "'Entries' button is NOT hittable")
			SoftAssert.shared.assertEqual(entriesTabBarButton.label,
										  LocalizedString.string(forKey: AccIDs.TabBar.entriesTabBarButton.rawValue),
										  "label does NOT match")
			SoftAssert.shared.assert(chartsTabBarButton.wait(),
					  "'Charts' button doesn't exists")
			SoftAssert.shared.assert(chartsTabBarButton.wait(state: .hittable),
					  "'Charts' button is NOT hittable")
			SoftAssert.shared.assertEqual(chartsTabBarButton.label,
										  LocalizedString.string(forKey: AccIDs.TabBar.chartsTabBarButton.rawValue),
										  "label does NOT match")
			SoftAssert.shared.assert(settingsTabBarButton.wait(),
					  "'Settings' button doesn't exists")
			SoftAssert.shared.assert(settingsTabBarButton.wait(state: .hittable),
					  "'Settings' button is NOT hittable")
			SoftAssert.shared.assertEqual(settingsTabBarButton.label,
										  LocalizedString.string(forKey: AccIDs.TabBar.settingsTabBarButton.rawValue),
										  "label does NOT match")
		}
		return self
	}
}
