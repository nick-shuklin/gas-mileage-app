import Foundation

/// UI element states used in custom wait methods to check for specific conditions on elements.
enum UIElementState: String {
	case exists = "exists"
	case hittable = "isHittable"
	case enabled = "isEnabled"
	case selected = "isSelected"
	case focused = "hasFocus"
}
