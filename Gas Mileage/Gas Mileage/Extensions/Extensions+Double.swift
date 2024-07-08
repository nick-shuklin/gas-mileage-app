//
//  Extensions+Double.swift
//  Gas Mileage
//
//  Created by Nick Shuklin on 6/12/24.
//

import Foundation
import SwiftUI

extension Color {
	init(hex: String) {
		let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
		var int: UInt64 = 0
		Scanner(string: hex).scanHexInt64(&int)
		let a, r, g, b: UInt64
		
		switch hex.count {
			case 3: // RGB (12-bit)
				(a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
			case 6: // RGB (24-bit)
				(a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
			case 8: // ARGB (32-bit)
				(a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
			default:
				(a, r, g, b) = (1, 1, 1, 0)
		}
		
		self.init(
			.sRGB,
			red: Double(r) / 255,
			green: Double(g) / 255,
			blue:  Double(b) / 255,
			opacity: Double(a) / 255
		)
	}
}

extension Double {
	func roundTo(places: Int) -> Double {
		let divisor = pow(10.0, Double(places))
		return (self * divisor).rounded() / divisor
	}
}

extension NumberFormatter {
	func totalFormat() -> NumberFormatter {
		let nf = NumberFormatter()
		nf.numberStyle = .decimal
		nf.maximumFractionDigits = 2
		return nf
	}
	
	func priceFormat() -> NumberFormatter {
		let nf = NumberFormatter()
		nf.numberStyle = .currency
		nf.allowsFloats = true
		nf.usesSignificantDigits = true
		nf.maximumFractionDigits = 2
		return nf
	}
	
//	let numberFormatter: NumberFormatter = {
//		let formatter = NumberFormatter()
//		formatter.minimum = .init(integerLiteral: 1)
//		formatter.maximum = .init(integerLiteral: Int.max)
//		formatter.generatesDecimalNumbers = false
//		formatter.maximumFractionDigits = 0
//		return formatter
//	}()
}
