//
//  GasMileageModel.swift
//  Gas Mileage
//
//  Created by Nick Shuklin on 6/6/24.
//

import Foundation

struct GasMileageModel {
	var entries: Array<Entry>
	
	struct Entry {
		var totalAmount: Double
		var gasStationName: GasStationName
		var gasPrice: Double
		var isFilledUp: Bool
		var volume: Double
		var gasMileage: Double
		var odometerReading: Int
	}
}

enum GasStationName: String {
	case shell = "Shell"
	case chevron = "Chevron"
	case lukoil = "Lukoil"
	case gazprom = "Gazprom"
	case mobil = "Mobil"
	case repsol = "Repsol"
	case valero = "Valero"
}
