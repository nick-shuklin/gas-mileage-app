import SwiftUI
import SwiftData

struct EditEntryView: View {
	static var nf = NumberFormatter()

	let entry: GasFillEntry?

	@State private var odometer: String = "4100"
	@State private var fillUpDate: Date = Date()
	@State private var total: Double = 45.0
	@State private var gasPrice: Double = 3.0
	@State private var volume: Double = 15.0
	@State private var gasMileage = 0.0
	@State private var isFilledUp: Bool = true
	@State private var selectedGasStationName: GasFillEntry.GasStationName = .chevron
	@State private var showAlert: Bool = false

	private var editorTitle: String {
		entry == nil ? "Add entry" : "Edit entry"
	}

	@Environment(\.dismiss) private var dismiss
	@Environment(\.modelContext) private var modelContext
	@Query(fetchDescriptorAll) private var items: [GasFillEntry]

	var body: some View {
		NavigationStack {
			Form {
				EntryDetailsSection(fillUpDate: $fillUpDate,
									selectedGasStationName: $selectedGasStationName)
				
				EntryDataSection(
					odometer: $odometer,
					total: $total,
					gasPrice: $gasPrice,
					volume: $volume,
					isFilledUp: $isFilledUp
				)
				
				Section {
					Toggle("Tank filled up?", isOn: $isFilledUp)
						.accessibilityIdentifier("tank_filled_toggle")
				}
			}
			.toolbar {
				ToolbarItem(placement: .cancellationAction) {
					Button("Cancel", role: .cancel) {
						dismiss()
					}
					.accessibilityIdentifier("cancel_button")
				}
				ToolbarItem(placement: .principal) {
					Text(editorTitle)
						.accessibilityIdentifier("title")
				}
				ToolbarItem(placement: .confirmationAction) {
					Button("Save") {
						withAnimation {
							verifyDate()

							if !showAlert {
								calculateGasMileage()
								save()
								dismiss()
							}
						}
					}
					.disabled(odometer.isEmpty)
					.accessibilityIdentifier("title")
				}
			}
			.onAppear {
				if let entry = entry {
					loadEntry(entry)
				}
			}
			.alert("Date is not correct", isPresented: $showAlert) {
				Button("Ok", role: .destructive) {
					showAlert.toggle()
				}
			} message: {
				Text("Please, check date or odometer reading")
			}
		}
	}
	
	private func calculateGasMileage() {
		let isNewEntryTheMostRecent = items.first?.odometer ?? 0 < Int(odometer)! ? true : false
		
		if isNewEntryTheMostRecent {
			if isFilledUp {
				var volumeBetweenFullTankFillUps = volume
				
				for item in items {
					if item.isFilledUp {
						gasMileage = Double(Int(odometer)! - item.odometer) / volumeBetweenFullTankFillUps
						break
					} else {
						volumeBetweenFullTankFillUps += item.volume
					}
				}
			} else {
				gasMileage = items.first?.gasMileage ?? -1.0
			}
		}
	}

	private func verifyDate() {
		for item in items {
			if (item.odometer < Int(odometer)!) && (item.fillUpDate > fillUpDate) ||
				(item.odometer > Int(odometer)!) && (item.fillUpDate < fillUpDate) {
				showAlert = true
			}
		}
	}
	
	private func loadEntry(_ entry: GasFillEntry) {
		odometer = String(entry.odometer)
		fillUpDate = entry.fillUpDate
		total = entry.total
		gasPrice = entry.gasPrice
		volume = entry.volume
		gasMileage = entry.gasMileage
		isFilledUp = entry.isFilledUp
		selectedGasStationName = entry.gasStationName
	}

	private func save() {
		if let entry = entry {
			entry.odometer = Int(odometer) ?? 0
			entry.fillUpDate = fillUpDate
			entry.total = total
			entry.gasPrice = gasPrice
			entry.volume = volume
			entry.gasMileage = gasMileage
			entry.isFilledUp = isFilledUp
			entry.gasStationName = selectedGasStationName
		} else {
			let newEntry = GasFillEntry(
				odometer: Int(odometer) ?? 0,
				fillUpDate: fillUpDate,
				total: total,
				gasPrice: gasPrice,
				volume: volume,
				gasMileage: gasMileage,
				isFilledUp: isFilledUp,
				gasStationName: selectedGasStationName
			)
			modelContext.insert(newEntry)
		}
	}
}

struct EntryDetailsSection: View {
	@Binding var fillUpDate: Date
	@Binding var selectedGasStationName: GasFillEntry.GasStationName

	var body: some View {
		Section {
			DatePicker("Fill up date", selection: $fillUpDate)
				.accessibilityIdentifier("fill_up_date_picker")
			
			Picker("Gas Station", selection: $selectedGasStationName) {
				ForEach(GasFillEntry.GasStationName.allCases, id: \.self) { name in
					Text(name.rawValue).tag(name)
				}
			}
			.pickerStyle(.menu)
			.accessibilityIdentifier("gas_station_picker")
		}
	}
}

struct EntryDataSection: View {
	@Binding var odometer: String
	@Binding var total: Double
	@Binding var gasPrice: Double
	@Binding var volume: Double
	@Binding var isFilledUp: Bool

	var body: some View {
		Section {
			VStack {
				HStack {
					Text("Odometer")
						.accessibilityIdentifier("odometer_text")
					Spacer()
					TextField("Odometer", text: $odometer)
						.keyboardType(.numberPad)
						.onChange(of: odometer) { _, newValue in
							odometer = newValue.filter { $0.isNumber }
						}
						.multilineTextAlignment(.trailing)
						.accessibilityIdentifier("odometer_textfield")
					Text("mi.")
				}

				HStack {
					Text("Total")
						.accessibilityIdentifier("total_text")
					Spacer()
					TextField("Total", value: $total, formatter: EditEntryView.nf.totalFormat())
						.keyboardType(.decimalPad)
						.onChange(of: total) { oldValue, newValue in
							if newValue < 0 {
								total = oldValue  // Prevent negative values
							}
						}
						.multilineTextAlignment(.trailing)
						.accessibilityIdentifier("total_textfield")
				}

				HStack {
					Text("Price")
						.accessibilityIdentifier("price_text")
					Spacer()
					TextField("Price", value: $gasPrice, formatter: EditEntryView.nf.priceFormat())
						.keyboardType(.decimalPad)
						.onChange(of: gasPrice) { oldValue, newValue in
							if newValue < 1 {
								gasPrice = oldValue  // Prevent negative values
							}
							if newValue >= 1 && newValue < 10 {
								volume = (total / gasPrice).roundTo(places: 2)
							}
						}
						.multilineTextAlignment(.trailing)
						.accessibilityIdentifier("price_textfield")
				}

				HStack {
					Text("Volume")
						.accessibilityIdentifier("volume_text")
					Spacer()
					TextField("Volume", value: $volume, formatter: EditEntryView.nf.totalFormat())
						.keyboardType(.decimalPad)
						.onChange(of: volume) { oldValue, newValue in
							if newValue < 1 {
								volume = oldValue
							}
							if newValue >= 1 && newValue < 50 {
								total = (volume * gasPrice).roundTo(places: 2)
							}
						}
						.multilineTextAlignment(.trailing)
						.accessibilityIdentifier("volume_textfield")
				}
			}
		}
	}
}
