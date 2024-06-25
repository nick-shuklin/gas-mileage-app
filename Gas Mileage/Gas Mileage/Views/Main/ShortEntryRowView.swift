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
			Text("Logo")
			Divider()
			Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .shortened))
				.bold()
				.lineLimit(1)
			Text("$" + String(item.gasPrice.roundTo(places: 2)) + "/gal")
			Text("$" + String(item.total.roundTo(places: 2)))
		}
		.font(.caption)
	}
}
