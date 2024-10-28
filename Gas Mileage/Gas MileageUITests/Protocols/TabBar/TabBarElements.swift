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
		return tabBar.buttons[AccIDs.TabBar.mainTabBarButton.rawValue].firstMatch
	}
	
	var entriesTabBarButton: XCUIElement {
		return tabBar.buttons[AccIDs.TabBar.entriesTabBarButton.rawValue].firstMatch
	}
	
	var chartsTabBarButton: XCUIElement {
		return tabBar.buttons[AccIDs.TabBar.chartsTabBarButton.rawValue].firstMatch
	}
	
	var settingsTabBarButton: XCUIElement {
		return tabBar.buttons[AccIDs.TabBar.settingsTabBarButton.rawValue].firstMatch
	}
}
