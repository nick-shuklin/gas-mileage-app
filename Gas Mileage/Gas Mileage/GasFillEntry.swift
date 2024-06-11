//
//  GasFillEntry.swift
//  Gas Mileage
//
//  Created by Nick Shuklin on 6/3/24.
//

import Foundation
import SwiftData

@Model
final class GasFillEntry {
	@Attribute(.unique) var odometerReading: Int
	var timestamp: Date
	var totalAmount: Double
	var gasPrice: Double
	var isFilledUp: Bool
	var volume: Double
	var gasMileage: Double
	var paidCash: Bool
	var gasStationName: GasStationName
    
    init(timestamp: Date) {
        self.timestamp = timestamp
		self.odometerReading = Int.random(in: 1...40000)
		self.totalAmount = 34
		self.gasPrice = 4.5
		self.isFilledUp = true
		self.volume = self.totalAmount/self.gasPrice
		self.gasMileage = 22.4
		self.paidCash = true
		self.gasStationName = .chevron
    }
}
