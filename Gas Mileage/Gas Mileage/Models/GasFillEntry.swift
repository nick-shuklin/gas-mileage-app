//
//  GasFillEntry.swift
//  Gas Mileage
//
//  Created by Nick Shuklin on 6/3/24.
//

import Foundation
import SwiftData

@Model
final class GasFillEntry: Codable {
	@Attribute(.unique) var odometer: Int
	var creationDate: Date
	var fillUpDate: Date
	var total: Double
	var gasPrice: Double
	var volume: Double
	var gasMileage: Double
	var isFilledUp: Bool
	var isPaidCash: Bool
	var gasStationName: GasStationName
    
	init(odometer: Int = Int.random(in: 1...500),
		 fillUpDate: Date = Date(),
		 total: Double = Double.random(in: 20...120),
		 gasPrice: Double = 4.349,
		 volume: Double = Double.random(in: 1...19),
		 gasMileage: Double = 0.0,
		 isFilledUp: Bool = Bool.random(),
		 isPaidCash: Bool = Bool.random(),
		 gasStationName: GasStationName = .chevron) {
		self.odometer = odometer
        self.creationDate = Date()
		self.fillUpDate = fillUpDate
		self.total = total
		self.gasPrice = gasPrice
		self.volume = volume
		self.gasMileage = gasMileage
		self.isFilledUp = isFilledUp
		self.isPaidCash = isPaidCash
		self.gasStationName = gasStationName
    }

	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		self.odometer = try container.decode(Int.self, forKey: .odometer)
		self.creationDate = try container.decode(Date.self, forKey: .creationDate)
		self.fillUpDate = try container.decode(Date.self, forKey: .fillUpDate)
		self.total = try container.decode(Double.self, forKey: .total)
		self.gasPrice = try container.decode(Double.self, forKey: .gasPrice)
		self.volume = try container.decode(Double.self, forKey: .volume)
		self.gasMileage = try container.decode(Double.self, forKey: .gasMileage)
		self.isFilledUp = try container.decode(Bool.self, forKey: .isFilledUp)
		self.isPaidCash = try container.decode(Bool.self, forKey: .isPaidCash)
		self.gasStationName = try container.decode(GasStationName.self, forKey: .gasStationName)
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		
		try container.encode(odometer, forKey: .odometer)
		try container.encode(creationDate, forKey: .creationDate)
		try container.encode(fillUpDate, forKey: .fillUpDate)
		try container.encode(total, forKey: .total)
		try container.encode(gasPrice, forKey: .gasPrice)
		try container.encode(volume, forKey: .volume)
		try container.encode(gasMileage, forKey: .gasMileage)
		try container.encode(isFilledUp, forKey: .isFilledUp)
		try container.encode(isPaidCash, forKey: .isPaidCash)
		try container.encode(gasStationName, forKey: .gasStationName)
	}
}

extension GasFillEntry {
	enum CodingKeys: CodingKey {
		case odometer, creationDate, fillUpDate, total, gasPrice
		case volume, gasMileage, isFilledUp, isPaidCash, gasStationName
	}
	
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
