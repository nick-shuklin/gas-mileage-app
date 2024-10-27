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
		return app.tabBars["Tab Bar"].firstMatch
	}
	
	var mainTabBarButton: XCUIElement {
		return tabBar.buttons["Main"].firstMatch
	}
	
	var entriesTabBarButton: XCUIElement {
		return tabBar.buttons["Entries"].firstMatch
	}
	
	var chartsTabBarButton: XCUIElement {
		return tabBar.buttons["Charts"].firstMatch
	}
	
	var settingsTabBarButton: XCUIElement {
		return tabBar.buttons["Settings"].firstMatch
	}
}
