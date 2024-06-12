//
//  EntryDetails.swift
//  Gas Mileage
//
//  Created by Nikolay Shuklin on 6/11/24.
//

import SwiftUI
import SwiftData

struct EntryDetails: View {
	@Environment(\.modelContext) private var modelContext
	@Query private var items: [GasFillEntry]
	var item: GasFillEntry
	
	var body: some View {
		VStack {
			Text(item.gasStationName.rawValue)
			Text(item.timestamp, format: Date.FormatStyle(date: .abbreviated, time: .shortened))
			Text(item.odometerReadingDescription)
			Text(item.gasPriceDescription)
			Text(item.totalAmountDescription)
			Text(item.gasMileageDescription)
			Text(item.volumeDescription)
		}
	}
}
