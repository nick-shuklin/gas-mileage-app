//
//  EditEntryView.swift
//  Gas Mileage
//
//  Created by Nick Shuklin on 6/12/24.
//

import SwiftUI
import SwiftData

struct EditEntryView: View {
	// FIXME: formatter should be specified separately for each value
	static var nf = NumberFormatter()
	
	let entry: GasFillEntry?
	
	@State private var odometer = ""
	@State private var creationDate = Date()
	@State private var timeOfFillUp = Date()
	@State private var total: Double = 0.0
	@State private var gasPrice: Double = 0.0
	@State private var volume: Double = 0.0
	@State private var gasMileage = 0.0
	@State private var isFilledUp = true
	@State private var isPaidCash = false
	@State private var selectedGasStationName: GasFillEntry.GasStationName = .chevron
		
	private var editorTitle: String {
		entry == nil ? "Add entry" : "Edit entry"
	}
	
	@Environment(\.dismiss) private var dismiss
	@Environment(\.modelContext) private var modelContext
	@Query(sort: \GasFillEntry.odometer, order: .reverse) private var items: [GasFillEntry]
	
    var body: some View {
		NavigationStack {
			Form {
				Section {
					DatePicker("Fill up date", selection: $timeOfFillUp)
					
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
									  text: $odometer
							)
							.keyboardType(.numberPad)
							.border(.secondary)
						
//							Text(odometer.debugDescription)
						}
						
						HStack {
							Text("Total")
							Spacer()
							TextField("Total",
									  value: $total,
									  formatter: EditEntryView.nf.totalFormat()
							)
//							.onTapGesture {
//								for item in items {
//									print(item.odometer)
//								}
//							}
							.keyboardType(.decimalPad)
							.border(.background)
							
//							Text(total.debugDescription)
						}
						
						HStack {
							Text("Price")
							Spacer()
							TextField("Price",
									  value: $gasPrice,
									  formatter: EditEntryView.nf.priceFormat()
							)
							.onChange(of: gasPrice) {
								volume = (total / gasPrice).roundTo(places: 2)
							}

							.keyboardType(.decimalPad)
							
//							Text(gasPrice.debugDescription)
						}
						
						HStack {
							Text("Volume")
							Spacer()
							TextField("Enter volume in gallons",
									  value: $volume,
									  formatter: EditEntryView.nf.totalFormat()
							)
							.onChange(of: volume) {
								total = (volume * gasPrice).roundTo(places: 2)
							}
							.keyboardType(.decimalPad)
							
//							Text(volume.debugDescription)
						}
					}
				}
				
				Section {
					Toggle(String("Tank filled up?"), isOn: $isFilledUp)
					Toggle(String("Paid cash?"), isOn: $isPaidCash)
				}
			}
			.toolbar {
				ToolbarItem(placement: .cancellationAction) {
					Button("Cancel", role: .cancel) {
						dismiss()
					}
				}
				
				ToolbarItem(placement: .principal) {
					Text(editorTitle)
				}
				
				ToolbarItem(placement: .confirmationAction) {
					Button("Save") {
						withAnimation {
							calculateGasMileage()
							save()
							dismiss()
						}
					}
					.disabled(odometer == "")
				}
			}
			.onAppear {
				if let entry {
					odometer = String(entry.odometer)
					timeOfFillUp = entry.timeOfFillUp
					total = entry.total
					gasPrice = entry.gasPrice
					volume = entry.volume
					gasMileage = entry.gasMileage
					isFilledUp = entry.isFilledUp
					isPaidCash = entry.isPaidCash
					selectedGasStationName = entry.gasStationName
				}
			}
		}
		.padding()
    }
	
	private func calculateGasMileage() {
//		var isTheMostRecent: Bool = false
//		
//		if
//			
		if isFilledUp {
			for item in items {
				if (item.odometer < Int(odometer)!) && item.isFilledUp {
					gasMileage = Double(Int(odometer)! - item.odometer) / volume
				}
			}
		} else {
			for item in items {
				if (item.odometer < Int(odometer)!){
					gasMileage = item.gasMileage
				}
			}
		}
	}
	
	private func save() {
		if let entry {
			entry.odometer = Int(odometer)!
			entry.timeOfFillUp = timeOfFillUp
			entry.total = total
			entry.gasPrice = gasPrice
			entry.volume = volume
			entry.gasMileage = gasMileage
			entry.isFilledUp = isFilledUp
			entry.isPaidCash = isPaidCash
			entry.gasStationName = selectedGasStationName
		} else {
			let newEntry = GasFillEntry(odometer: Int(odometer)!,
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
