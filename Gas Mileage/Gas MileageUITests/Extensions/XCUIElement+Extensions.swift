import Foundation
import XCTest

extension XCUIElement {
	
	/// Attempts to tap on the `XCUIElement` if it exists and is hittable within a specified timeout period.
	///
	/// This method waits for the element to be in a hittable state within the given timeout duration. If the element becomes hittable,
	/// the method performs a tap action on it. If the element fails to become hittable or does not exist, it triggers a failure and logs an error message.
	///
	/// - Parameter timeout: The duration to wait for the element to become hittable. The default value is `.veryShort`.
	///
	/// - Important: If the element is not found or is not hittable within the specified timeout, the test fails with a detailed error message indicating the element's debug description.
	///
	/// - Precondition: The element must exist and be hittable within the specified timeout duration to successfully perform the tap action.
	///
	/// - Note: This method uses the `wait` function to check the element’s state and performs an assertion to ensure the element is interactable before attempting the tap.
	///
	/// - SeeAlso: `wait(state:for:delay:)` for more information about the waiting mechanism used internally.
	///
	/// - Example:
	/// ```swift
	/// // Assuming `continueButton` is an XCUIElement
	/// continueButton.tapElement(.medium) // Attempts to tap the button with a medium timeout
	/// ```
	///
	/// - Parameters:
	///   - timeout: A `Timeouts` value defining how long to wait for the element to become hittable. Defaults to `.veryShort`.
	///
	/// - Throws: This method does not throw an error but triggers a failure using `XCTFail` if the element is not hittable or does not exist within the specified timeout.
	func tapElement(_ timeout: Timeouts = .veryShort) {
		if wait(state: .hittable, for: timeout) {
			tap()
		} else {
			XCTFail("\(Icons.error.rawValue) Element is not hittable or does not exist - '\(debugDescription)'")
		}
	}
	
	/// Attempts to tap the `XCUIElement` if it is present and hittable within a specified timeout period.
	///
	/// This method checks if the element is in a hittable state within the given timeout duration. If the element is hittable,
	/// it performs a tap action. If the element is not found or not hittable within the timeout period, the method quietly exits without any assertion or failure.
	///
	/// - Parameter timeout: The duration to wait for the element to become hittable. The default value is `.veryShort`.
	///
	/// - Important: This method does not fail or throw an error if the element is not hittable or does not exist within the timeout. It is useful for scenarios where the presence of the element is not guaranteed or when tapping on the element is optional.
	///
	/// - Note: Unlike `tapElement(_:)`, this method does not assert or log an error message if the element is not found or not hittable.
	///
	/// - SeeAlso: `wait(state:for:delay:)` for the internal waiting mechanism used to check the element’s state.
	///
	/// - Example:
	/// ```swift
	/// // Assuming `optionalButton` is an XCUIElement
	/// optionalButton.tapElementIfPresent(.medium) // Attempts to tap the button if it becomes hittable within a medium timeout
	/// ```
	///
	/// - Parameters:
	///   - timeout: A `Timeouts` value defining how long to wait for the element to become hittable. Defaults to `.veryShort`.
	///
	/// - Returns: This method does not return a value or throw an error. It simply performs a tap action if the element is hittable.
	func tapElementIfPresent(_ timeout: Timeouts = .veryShort) {
		if wait(state: .hittable, for: timeout) {
			tap()
		}
	}
	
	/// Retrieves the value of the `XCUIElement` as a `String`.
	///
	/// This method attempts to cast the element’s value to a `String`. If the cast is successful, the method returns the string representation of the element’s value. If the cast fails, the method returns an empty string.
	///
	/// - Returns: A `String` representation of the element’s value, or an empty string if the value is not of type `String`.
	///
	/// - Note: This method provides a safe way to extract the value of the element without causing a runtime error if the value is not a `String`. It is especially useful for elements like text fields or labels, where the value is expected to be a string.
	///
	/// - Example:
	/// ```swift
	/// // Assuming `textField` is an XCUIElement
	/// let text = textField.valueAsString() // Retrieves the value of the text field as a String
	/// ```
	///
	/// - SeeAlso: `XCUIElement.value` for more details on the value property of XCUIElement.
	func valueAsString() -> String {
		return value as? String ?? ""
	}
	
	/// Waits for the `XCUIElement` to reach a specified state within a given timeout period.
	///
	/// This method checks the current state of the element based on the provided `UIElementState` parameter and waits for the element
	/// to reach the desired state (e.g., exists, hittable, enabled, selected, or focused). If `delay` is set to `false`, it immediately checks the current state
	/// of the element before initiating the wait.
	///
	/// - Parameters:
	///   - state: The desired state of the element to wait for. The default value is `.exists`.
	///   - result: A Boolean indicating the expected result for the state. Default is `true`.
	///   - timeout: The duration to wait for the element to reach the desired state. The default value is `.short`.
	///   - delay: A Boolean indicating whether to delay the state check initially. Default is `false`.
	///
	/// - Returns: A Boolean indicating whether the element reached the desired state within the timeout duration.
	///
	/// - Note: If `delay` is set to `false`, the method checks the state immediately before waiting. If the element is already in the expected state,
	/// the method returns `true` without waiting.
	///
	/// - Example:
	/// ```swift
	/// // Waits for an element to be hittable within a medium timeout period
	/// let isHittable = someElement.wait(state: .hittable, for: .medium)
	/// ```
	func wait(state: UIElementState = .exists,
			  result: Bool = true,
			  for timeout: Timeouts = .short,
			  delay: Bool = false) -> Bool {
		// Check the current state without delay
		if !delay, isStateValid(state, expectedResult: result) {
			return true
		}

		// Create a predicate based on the state and expected result
		let predicate = NSPredicate(format: "\(state.rawValue) == \(result ? "true" : "false")")
		let expectation = XCTNSPredicateExpectation(predicate: predicate, object: self)
		
		// Wait for the predicate to be satisfied within the timeout period
		return XCTWaiter.wait(for: [expectation], timeout: timeout.rawValue) == .completed
	}

	/// Helper method to check if the element is in the desired state
	private func isStateValid(_ state: UIElementState, expectedResult: Bool) -> Bool {
		switch state {
		case .exists: return (expectedResult == exists)
		case .hittable: return (expectedResult == isHittable)
		case .enabled: return (expectedResult == isEnabled)
		case .selected: return (expectedResult == isSelected)
		case .focused: return (expectedResult == hasFocus)
		}
	}
	
	/// A Boolean value indicating whether the `XCUIElement` (assumed to be a switch) is in the checked state.
	///
	/// This computed property checks if the element is of type `.switch`. If it is, the property returns `true` if the element's value is "1" (indicating the switch is on or checked).
	/// Otherwise, it returns `false` and raises an assertion if the element type is not `.switch`.
	///
	/// - Important: This property is specifically designed for elements of type `.switch`. Using it on other element types will trigger an assertion failure.
	///
	/// - Returns: `true` if the element is a switch and its value indicates it is checked, otherwise `false`.
	///
	/// - Example:
	/// ```swift
	/// // Assuming `toggleSwitch` is an XCUIElement of type .switch
	/// if toggleSwitch.isChecked {
	///     print("The switch is turned on.")
	/// }
	/// ```
	///
	/// - SeeAlso: `XCUIElement.elementType` and `XCUIElement.value` for more information about checking element types and values.
	var isChecked: Bool {
		// Assert if the element type is not `.switch`
		XCTAssert(elementType == .switch,
				  "isChecked should only be used on elements of type .switch, but was used on element type: \(elementType)")

		// Return true if the element's value indicates that it is checked
		return (value as? String) == "1"
	}
	
	/// Forces a tap on the `XCUIElement` using a specified offset within the element’s coordinate space.
	///
	/// This method taps on the element at a position determined by the provided offset values for the x and y coordinates. The offset values are normalized,
	/// with a default of `(0.5, 0.5)` which corresponds to the center of the element. This method is useful when a direct tap on the element might not work due to
	/// hit-testing issues or other UI complexities.
	///
	/// - Parameters:
	///   - dx: A normalized offset value for the x-axis. Defaults to `0.5` (center horizontally).
	///   - dy: A normalized offset value for the y-axis. Defaults to `0.5` (center vertically).
	///
	/// - Note: This method converts the normalized offset into the element’s coordinate space to perform the tap action. It can help in scenarios where the default tap method does not succeed due to specific UI constraints or configurations.
	///
	/// - Example:
	/// ```swift
	/// // Assuming `someElement` is an XCUIElement
	/// someElement.forceTapWithOffset(dx: 0.2, dy: 0.8) // Taps near the bottom-left of the element
	/// ```
	///
	/// - SeeAlso: `XCUIElement.coordinate(withNormalizedOffset:)` for more information about interacting with element coordinates.
	func forceTapWithOffset(dx: Double = 0.5,
							dy: Double = 0.5) {
		coordinate(withNormalizedOffset: CGVector(dx: dx, dy: dy)).tap()
	}
}
