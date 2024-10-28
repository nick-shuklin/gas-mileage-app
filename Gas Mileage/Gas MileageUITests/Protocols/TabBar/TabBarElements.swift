import Foundation
import XCTest

protocol TabBarElements: BaseScreen {
	var tabBar: XCUIElement { get }
	var mainTabBarButton: XCUIElement { get }
	var entriesTabBarButton: XCUIElement { get }
	var chartsTabBarButton: XCUIElement { get }
	var settingsTabBarButton: XCUIElement { get }
}

extension TabBarElements {
	var tabBar: XCUIElement {
		return app.tabBars[LocalizedString.string(forKey: "Tab Bar")].firstMatch
	}
	
	var mainTabBarButton: XCUIElement {
		// Since the app complexity is simple, we search for all elements directly in the entire view hierarchy (VH).
		// This is an example of a hybrid approach to ensure robustness in cases where the parent element might not be found.
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
