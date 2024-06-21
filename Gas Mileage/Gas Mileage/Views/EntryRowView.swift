//
//  EntryRowView.swift
//  Gas Mileage
//
//  Created by Nick Shuklin on 6/11/24.
//

import SwiftUI

struct EntryRowView: View {
	var item: GasFillEntry
	@Environment(\.locale) var locale: Locale
	
    var body: some View {
		VStack {
			HStack(alignment: .center) {
				Text(item.timestamp, format: Date.FormatStyle(date: .abbreviated, time: .shortened))
					.bold()
//				Spacer()
			}
			HStack {
				VStack(alignment: .leading) {
					Text(item.gasStationName.rawValue)
					Text(item.isPaidCash ? "Cash" : "Card")
				}
				VStack(alignment: .leading) {
					Text(locale.identifier)
					if locale.identifier == "en" {
						Text("\(item.odometer) miles")
						Text("$ " + String(item.gasPrice.roundTo(places: 2)) + " per gal")
					} else if locale.identifier == "ru" {
						Text("\(item.odometer) km")
						Text("$ " + String(item.gasPrice.roundTo(places: 2)) + " per gal")
					}
				}
				.lineLimit(1)
				VStack(alignment: .leading) {
					Text("$ " + String(item.total.roundTo(places: 2)))
					if locale.identifier == "en" {
						Text(String(item.gasMileage?.roundTo(places: 2) ?? 0) + " mpg")
						Text(String(item.volume.roundTo(places: 2)) + " gal")
					}
				}
			}
		}
		.font(.caption)
    }
}
