//
//  ShortEntryRowView.swift
//  Gas Mileage
//
//  Created by Nick Shuklin on 6/21/24.
//

import SwiftUI

struct ShortEntryRowView: View {
	var item: GasFillEntry
	
	var body: some View {
		HStack {
			Text("Logo") // here will be small gas station logo pic
			Divider()
			Text(item.creationDate, format: Date.FormatStyle(date: .numeric, time: .shortened))
				.bold()
				.lineLimit(1)
			Text("$" + String(item.gasPrice.roundTo(places: 2)) + "/gal")
			Text("$" + String(item.total.roundTo(places: 2)))
		}
		.font(.caption)
	}
}

#Preview {
	ShortEntryRowView(item: GasFillEntry())
		.modelContainer(for: GasFillEntry.self, inMemory: true)
}

