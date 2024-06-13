//
//  Extensions+Double.swift
//  Gas Mileage
//
//  Created by Nikolay Shuklin on 6/12/24.
//

import Foundation

extension Double {
	func roundTo(places: Int) -> Double {
		let divisor = pow(10.0, Double(places))
		return (self * divisor).rounded() / divisor
	}
}
