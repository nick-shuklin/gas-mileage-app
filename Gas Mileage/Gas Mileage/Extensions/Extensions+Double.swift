//
//  Extensions+Double.swift
//  Gas Mileage
//
//  Created by Nick Shuklin on 6/12/24.
//

import Foundation

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
		return nf
	}
	
	func priceFormat() -> NumberFormatter {
		let nf = NumberFormatter()
		nf.numberStyle = .currency
		nf.allowsFloats = true
		nf.usesSignificantDigits = true
		return nf
	}
}
