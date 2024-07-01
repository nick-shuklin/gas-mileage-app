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
	var creationDate: Date
	var timeOfFillUp: Date
	var total: Double
	var gasPrice: Double
	var volume: Double
	var gasMileage: Double
	var isFilledUp: Bool
	var isPaidCash: Bool
	var gasStationName: GasStationName
    
	init(odometer: Int = Int.random(in: 1...500),
		 timeOfFillUp: Date = Date(),
		 total: Double = Double.random(in: 20...120),
		 gasPrice: Double = 4.349,
		 volume: Double = Double.random(in: 1...19),
		 gasMileage: Double = 0.0,
		 isFilledUp: Bool = Bool.random(),
		 isPaidCash: Bool = Bool.random(),
		 gasStationName: GasStationName = .chevron) {
		self.odometer = odometer
        self.creationDate = Date()
		self.timeOfFillUp = timeOfFillUp
		self.total = total
		self.gasPrice = gasPrice
		self.volume = volume
		self.gasMileage = gasMileage
		self.isFilledUp = isFilledUp
		self.isPaidCash = isPaidCash
		self.gasStationName = gasStationName
    }
}

extension GasFillEntry {
	enum GasStationName: String, Codable, CaseIterable {
		case shell = "Shell"
		case chevron = "Chevron"
		case lukoil = "Lukoil"
		case gazprom = "Gazprom"
		case mobil = "Mobil"
		case repsol = "Repsol"
		case valero = "Valero"
	}
}
