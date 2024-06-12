//
//  EntryRow.swift
//  Gas Mileage
//
//  Created by Nikolay Shuklin on 6/11/24.
//

import SwiftUI

struct EntryRow: View {
	var item: GasFillEntry
	
    var body: some View {
		HStack {
			VStack(alignment: .leading) {
				Text(item.gasStationName.rawValue)
			}
			VStack(alignment: .leading) {
				Text(item.odometerReadingDescription)
				Text(item.gasPriceDescription)
				Text(item.timestamp, format: Date.FormatStyle(date: .abbreviated, time: .shortened))
			}
			.lineLimit(1)
			VStack(alignment: .leading) {
				Text(item.totalAmountDescription)
				Text(item.gasMileageDescription)
				Text(item.volumeDescription)
			}
		}
		.font(.caption)
    }
}
