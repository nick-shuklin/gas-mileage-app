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
	@Attribute(.unique) var odometer: Int
	var timestamp: Date
	var total: Double
	var gasPrice: Double
	var volume: Double
	var gasMileage: Double?
	var isFilledUp: Bool
	var isPaidCash: Bool
	var gasStationName: GasStationName
    
	init(odometer: Int,
		 timestamp: Date,
		 total: Double,
		 gasPrice: Double,
		 volume: Double,
		 gasMileage: Double,
		 gasStationName: GasStationName) {
		self.odometer = odometer
        self.timestamp = timestamp
		self.total = total
		self.gasPrice = gasPrice
		self.volume = volume
		self.gasMileage = gasMileage
		self.isFilledUp = true
		self.isPaidCash = false
		self.gasStationName = gasStationName
    }
	
	init(timestamp: Date) {
		self.timestamp = timestamp
		self.odometer = Int.random(in: 1...200000)
		self.total = 1
		self.gasPrice = 4.499
		self.isFilledUp = true
		self.volume = 18.5
		self.isPaidCash = true
		self.gasStationName = .chevron
	}
}
