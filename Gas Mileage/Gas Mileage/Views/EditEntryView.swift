//
//  EditEntryView.swift
//  Gas Mileage
//
//  Created by Nick Shuklin on 6/12/24.
//

import SwiftUI

struct EditEntryView: View {
	@Bindable var item: GasFillEntry
	@Environment(\.dismiss) private var dismiss
	@Environment(\.modelContext) private var modelContext
	// FIXME: formatter should be specified separately for each value
	static var nf = NumberFormatter()
	
    var body: some View {
		Form {
			Section {
				DatePicker("Date", selection: $item.timestamp)
				Picker("Gas Station", selection: $item.gasStationName) {
					ForEach(GasStationName.allCases) { name in
						Text(name.rawValue)
							.tag(name)
					}
				}
				.pickerStyle(.menu)
			}
			Section {
				VStack {
					HStack {
						Text("Odometer")
						Spacer()
						TextField(
							"Odometer",
							value: $item.odometer,
							formatter: EditEntryView.nf,
							onEditingChanged: { _ in
								
							}, onCommit: {
								
						})
						.keyboardType(.numberPad)
					}
					HStack {
						Text("Total")
						Spacer()
						TextField(
							"Total",
							value: $item.total,
							formatter: EditEntryView.nf,
							onEditingChanged: { _ in
								
							}, onCommit: {
								
						})
						.keyboardType(.decimalPad)
						.border(.background)
					}
					HStack {
						Text("Price")
						Spacer()
						TextField(
							"Price",
							value: $item.gasPrice,
							formatter: EditEntryView.nf,
							onEditingChanged: { _ in
								
							}, onCommit: {
								
						})
						.keyboardType(.decimalPad)
					}
					HStack {
						Text("Volume")
						Spacer()
						TextField(
							"Volume",
							value: $item.volume,
							formatter: EditEntryView.nf,
							onEditingChanged: { _ in
								
							}, onCommit: {
								
						})
						.keyboardType(.decimalPad)
					}
				}
			}
			Section {
				Toggle(String("Tank filled up?"), isOn: $item.isFilledUp)
				Toggle(String("Paid cash?"), isOn: $item.isPaidCash)
			}
		}
		HStack {
			Button("Cancel") {
				dismiss()
			}
			Spacer()
			Button("Confirm") {
				modelContext.insert(item)
				dismiss()
			}
		}
		.padding(20)
    }
}
