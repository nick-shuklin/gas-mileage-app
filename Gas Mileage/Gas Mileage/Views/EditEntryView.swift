//
//  EditEntryView.swift
//  Gas Mileage
//
//  Created by Nick Shuklin on 6/12/24.
//

import SwiftUI
import SwiftData

struct EditEntryView: View {
//	@Bindable var item: GasFillEntry
	// FIXME: formatter should be specified separately for each value
	static var nf = NumberFormatter()
	
	let entry: GasFillEntry?
	
	@State private var odometer = 1111
	@State private var creationDate = Date()
	@State private var timeOfFillUp = Date()
	@State private var total = 10.40
	@State private var gasPrice = 3.299
	@State private var volume = 15.5
	@State private var gasMileage = 15.7
	@State private var isFilledUp = true
	@State private var isPaidCash = false
	@State private var selectedGasStationName: GasFillEntry.GasStationName = .chevron
		
	private var editorTitle: String {
		entry == nil ? "Add entry" : "Edit entry"
	}
	
	@Environment(\.dismiss) private var dismiss
	@Environment(\.modelContext) private var modelContext
	
//	@Query(sort: \GasFillEntry.odometer, order: .reverse) private var items: [GasFillEntry]
	
    var body: some View {
		NavigationStack {
			Form {
				Section {
					DatePicker("Date of fill up", selection: $timeOfFillUp)
					
					Picker("Gas Station", selection: $selectedGasStationName) {
						ForEach(GasFillEntry.GasStationName.allCases, id: \.self) { name in
							Text(name.rawValue).tag(name)
						}
					}
					.pickerStyle(.menu)
				}
				Section {
					VStack {
						HStack {
							Text("Odometer")
							Spacer()
							TextField("Odometer",
									  value: $odometer,
									  formatter: EditEntryView.nf)
							.keyboardType(.numberPad)
						}
						HStack {
							Text("Total")
							Spacer()
							TextField("Total",
									  value: $total,
									  formatter: EditEntryView.nf.totalFormat())
							.keyboardType(.decimalPad)
							.border(.background)
						}
						HStack {
							Text("Price")
							Spacer()
							TextField("Price",
									  value: $gasPrice,
									  formatter: EditEntryView.nf.priceFormat())
							.keyboardType(.decimalPad)
						}
						HStack {
							Text("Volume")
							Spacer()
							TextField("Enter volume in gallons",
									  value: $volume,
									  formatter: EditEntryView.nf.totalFormat())
							.keyboardType(.decimalPad)
						}
						HStack {
							Text("Gas mileage")
							Spacer()
							TextField("miles per gallon",
									  value: $gasMileage,
									  formatter: EditEntryView.nf.totalFormat())
							.keyboardType(.decimalPad)
						}
					}
				}
				Section {
					Toggle(String("Tank filled up?"), isOn: $isFilledUp)
					Toggle(String("Paid cash?"), isOn: $isPaidCash)
				}
			}
			.toolbar {
				ToolbarItem(placement: .principal) {
					Text(editorTitle)
				}
				
				ToolbarItem(placement: .confirmationAction) {
					Button("Save") {
						withAnimation {
							save()
							dismiss()
						}
					}
					// Require a category to save changes.
//					.disabled(gasStationName. == nil)
				}
				
				ToolbarItem(placement: .cancellationAction) {
					Button("Cancel", role: .cancel) {
						dismiss()
					}
				}
			}
			.onAppear {
				if let entry {
					// Edit the incoming entry.
					odometer = entry.odometer
					timeOfFillUp = entry.timeOfFillUp
					isFilledUp = entry.isFilledUp
				}
			}
			.padding()
		}
    }
	
	private func save() {
		if let entry {
			// Edit the entry.
			entry.odometer = odometer
			entry.timeOfFillUp = timeOfFillUp
			entry.total = total
			entry.gasPrice = gasPrice
			entry.volume = volume
			entry.gasMileage = gasMileage
			entry.isFilledUp = isFilledUp
			entry.isPaidCash = isPaidCash
			entry.gasStationName = selectedGasStationName
		} else {
			// Add an entry.
			let newEntry = GasFillEntry(odometer: odometer,
										timeOfFillUp: timeOfFillUp,
										total: total,
										gasPrice: gasPrice,
										volume: volume,
										gasMileage: gasMileage,
										isFilledUp: isFilledUp,
										isPaidCash: isPaidCash,
										gasStationName: selectedGasStationName)
			modelContext.insert(newEntry)
		}
	}
}
