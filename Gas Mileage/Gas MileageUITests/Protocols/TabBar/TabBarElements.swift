import Foundation
import XCTest

/// Protocol defining common elements in the app's tab bar.
protocol TabBarElements: BaseScreen {
	var tabBar: XCUIElement { get }
	var mainTabBarButton: XCUIElement { get }
	var entriesTabBarButton: XCUIElement { get }
	var chartsTabBarButton: XCUIElement { get }
	var settingsTabBarButton: XCUIElement { get }
}

extension TabBarElements {
	
	/// Retrieves the tab bar container, identified by its localized accessibility identifier.
	var tabBar: XCUIElement {
		return app.tabBars[LocalizedString.string(forKey: "Tab Bar")].firstMatch
	}
	
	/// Main tab button with fallback for direct view hierarchy search.
	///
	/// This uses a hybrid approach to improve robustness: if the element isn't found within the tab bar, it falls back to searching the entire view hierarchy.
	var mainTabBarButton: XCUIElement {
		let element = tabBar.buttons[AccIDs.TabBar.mainTabBarButton.rawValue].firstMatch
		return element.exists ? element : app.buttons[AccIDs.TabBar.mainTabBarButton.rawValue].firstMatch
	}
	
	var entriesTabBarButton: XCUIElement {
		return app.buttons[AccIDs.TabBar.entriesTabBarButton.rawValue].firstMatch
	}
	
	var chartsTabBarButton: XCUIElement {
		return app.buttons[AccIDs.TabBar.chartsTabBarButton.rawValue].firstMatch
	}
	
	var settingsTabBarButton: XCUIElement {
		return app.buttons[AccIDs.TabBar.settingsTabBarButton.rawValue].firstMatch
	}
}
