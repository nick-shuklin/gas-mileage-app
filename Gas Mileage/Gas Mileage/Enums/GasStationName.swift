//
//  GasStationName.swift
//  Gas Mileage
//
//  Created by Nick Shuklin on 6/6/24.
//

import Foundation

enum GasStationName: String, Codable, CaseIterable, Identifiable {
	case shell = "Shell"
	case chevron = "Chevron"
	case lukoil = "Lukoil"
	case gazprom = "Gazprom"
	case mobil = "Mobil"
	case repsol = "Repsol"
	case valero = "Valero"
	var id: String { self.rawValue }
}
