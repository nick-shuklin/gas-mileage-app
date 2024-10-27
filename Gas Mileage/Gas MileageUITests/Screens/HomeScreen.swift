import Foundation
import XCTest

class HomeScreen: BaseScreen, TabBarProtocol {
	// MARK: - Static Screen Elements
	private lazy var mainTabView = app.otherElements["main_tab"].firstMatch
	
	// MARK: - Labels
	private let failureMessageAddOn = "'Home Screen'"
	
	init() {
		assertScreenIsDisplayed()
	}
	
	internal func assertScreenIsDisplayed() {
		runActivity(.screen, "Then verify \(failureMessageAddOn) is loaded") {
			XCTAssert(mainTabView.wait(for: .long),
					  "\(err) \(failureMessageAddOn) is NOT displayed because Main Tab is NOT displayed")
		}
	}
	
	// MARK: - Navigation & UI Interactions
//	@discardableResult
//	func tapSignUpButton() -> Self {
//		runActivity(.step, "Then tap 'Sign Up' button") {
//			viewBoardButton.tapElement()
//		}
//		return self
//	}
	
	// MARK: - Assertions
//	@discardableResult
//	func verifyAllStaticElements() -> Self {
//		let message = "Then verify all static elements"
//		Configuration.stepByStepMessage.append("\n*\(message)")
//		runActivity(.assert, message) {
//			XCTAssert(signUpButton.wait(),
//					  "\(err) 'Sign Up' button doesn't exists on \(failureMessageAddOn)")
//			XCTAssert(signInButton.wait(),
//					  "\(err) 'Sign in' button doesn't exists on \(failureMessageAddOn)")
//			XCTAssert(viewBoardButton.wait(),
//					  "\(err) 'VIEW BOARD' button doesn't exists on \(failureMessageAddOn)")
//		}
//		return self
//	}
}
