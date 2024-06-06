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
		var gasStationName: String
	}
}
