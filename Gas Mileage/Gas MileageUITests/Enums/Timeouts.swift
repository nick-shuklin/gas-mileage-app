import Foundation

/// Predefined timeout intervals used for waiting in UI tests.
enum Timeouts: TimeInterval {
	case veryShort = 1
	case short = 3
	case medium = 5
	case long = 7
	case veryLong = 20
}
