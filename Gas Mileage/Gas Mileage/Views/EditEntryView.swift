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
	static var nf = NumberFormatter()
	
    var body: some View {
		Form {
			Section {
				DatePicker("Date", selection: $item.timestamp)
				// TODO: add all station name cases
				Picker("Gas Station", selection: $item.gasStationName) {
					Text("Shell")
						.tag(GasStationName.shell)
					Text("Chevron")
						.tag(GasStationName.chevron)
					Text("Mobil")
						.tag(GasStationName.mobil)
				}
				.pickerStyle(.menu)
			}
			Section {
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
					.keyboardType(.numberPad)
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
