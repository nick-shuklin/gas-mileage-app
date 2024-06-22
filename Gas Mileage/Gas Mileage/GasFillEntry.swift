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
    
	init(odometer: Int = Int.random(in: 1...500),
		 timestamp: Date,
		 total: Double = Double.random(in: 30...150),
		 gasPrice: Double = 4.349,
		 volume: Double = Double.random(in: 1...19),
		 gasMileage: Double? = nil,
		 isFilledUp: Bool = Bool.random(),
		 isPaidCash: Bool = Bool.random(),
		 gasStationName: GasStationName = .chevron) {
		self.odometer = odometer
        self.timestamp = timestamp
		self.total = total
		self.gasPrice = gasPrice
		self.volume = volume
		self.gasMileage = gasMileage
		self.isFilledUp = isFilledUp
		self.isPaidCash = isPaidCash
		self.gasStationName = gasStationName
    }
	
//	init(timestamp: Date) {
//		self.timestamp = timestamp
//		self.odometer = Int.random(in: 1...200)
//		self.total = 1
//		self.gasPrice = 4.499
//		self.isFilledUp = true
//		self.volume = Double.random(in: 1...19)
//		self.isPaidCash = true
//		self.gasStationName = .chevron
//	}
}
