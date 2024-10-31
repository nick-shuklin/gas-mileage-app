import Foundation
import XCTest

/// Protocol defining navigation actions on tab bar elements.
protocol TabBarProtocol: TabBarElements {
	func tapMainTabBarButton() -> Self
	func tapEntriesTabBarButton() -> Self
	func tapChartsTabBarButton() -> Self
	func tapSettingsTabBarButton() -> Self
	func verifyTabBarElements() -> Self
}

extension TabBarProtocol {
	
	// MARK: - Navigation & UI Interactions
	
	/// Taps the Main tab bar button and verifies it is selected.
	@discardableResult
	func tapMainTabBarButton() -> Self {
		runActivity(.step, "Then tap 'Main' tab bar button") {
			mainTabBarButton.tapElement()
			XCTAssert(mainTabBarButton.wait(state: .selected),
					  "\(err) 'Main' tab bar button is NOT selected")
		}
		return self
	}
	
	/// Taps the Entries tab bar button and verifies it is selected.
	@discardableResult
	func tapEntriesTabBarButton() -> Self {
		runActivity(.step, "Then tap 'Entries' tab bar button") {
			entriesTabBarButton.tapElement()
			XCTAssert(entriesTabBarButton.wait(state: .selected),
					  "\(err) 'Entries' tab bar button is NOT selected")
		}
		return self
	}
	
	/// Taps the Charts tab bar button and verifies it is selected.
	@discardableResult
	func tapChartsTabBarButton() -> Self {
		runActivity(.step, "Then tap 'Charts' tab bar button") {
			chartsTabBarButton.tapElement()
			XCTAssert(chartsTabBarButton.wait(state: .selected),
					  "\(err) 'Charts' tab bar button is NOT selected")
		}
		return self
	}
	
	/// Taps the Settings tab bar button and verifies it is selected.
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
	
	/// Verifies that all tab bar elements exist, are hittable, and have correct labels.
	@discardableResult
	func verifyTabBarElements() -> Self {
		runActivity(.assert, "Then verify all Tab Bar buttons exist, are hittable, and labels match") {
			SoftAssert.shared.assert(tabBar.wait(), "'Tab Bar' doesn't exist")
			SoftAssert.shared.assert(mainTabBarButton.wait(), "'Main' button doesn't exist")
			SoftAssert.shared.assert(mainTabBarButton.wait(state: .hittable), "'Main' button is NOT hittable")
			SoftAssert.shared.assertEqual(mainTabBarButton.label,
										  LocalizedString.string(forKey: AccIDs.TabBar.mainTabBarButton.rawValue),
										  "label does NOT match")
			SoftAssert.shared.assert(entriesTabBarButton.wait(), "'Entries' button doesn't exist")
			SoftAssert.shared.assert(entriesTabBarButton.wait(state: .hittable), "'Entries' button is NOT hittable")
			SoftAssert.shared.assertEqual(entriesTabBarButton.label,
										  LocalizedString.string(forKey: AccIDs.TabBar.entriesTabBarButton.rawValue),
										  "label does NOT match")
			SoftAssert.shared.assert(chartsTabBarButton.wait(), "'Charts' button doesn't exist")
			SoftAssert.shared.assert(chartsTabBarButton.wait(state: .hittable), "'Charts' button is NOT hittable")
			SoftAssert.shared.assertEqual(chartsTabBarButton.label,
										  LocalizedString.string(forKey: AccIDs.TabBar.chartsTabBarButton.rawValue),
										  "label does NOT match")
			SoftAssert.shared.assert(settingsTabBarButton.wait(), "'Settings' button doesn't exist")
			SoftAssert.shared.assert(settingsTabBarButton.wait(state: .hittable), "'Settings' button is NOT hittable")
			SoftAssert.shared.assertEqual(settingsTabBarButton.label,
										  LocalizedString.string(forKey: AccIDs.TabBar.settingsTabBarButton.rawValue),
										  "label does NOT match")
		}
		return self
	}
}
