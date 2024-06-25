//
//  EntryRowView.swift
//  Gas Mileage
//
//  Created by Nick Shuklin on 6/11/24.
//

import SwiftUI

struct EntryRowView: View {
	var item: GasFillEntry
	
    var body: some View {
		HStack {
			VStack(alignment: .leading) {
				Text(item.gasStationName.rawValue).bold()
				Text(item.isPaidCash ? "Cash" : "Card")
			}
			VStack(alignment: .leading) {
				Text(item.creationDate, format: Date.FormatStyle(date: .abbreviated, time: .shortened)).bold()
				Text("\(item.odometer) miles")
				Text("$ " + String(item.gasPrice.roundTo(places: 2)) + " per gal")
			}
			.lineLimit(1)
			VStack(alignment: .leading) {
				Text("$ " + String(item.total.roundTo(places: 2)))
				Text(String(item.gasMileage?.roundTo(places: 2) ?? 0) + " mpg")
				Text(String(item.volume.roundTo(places: 2)) + " gal")
			}
		}
		.font(.caption)
    }
}
