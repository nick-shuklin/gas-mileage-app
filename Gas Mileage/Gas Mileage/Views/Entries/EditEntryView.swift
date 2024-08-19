import SwiftUI
import SwiftData

struct EditEntryView: View {
	// FIXME: formatter should be specified separately for each value
	static var nf = NumberFormatter()
	
	let entry: GasFillEntry?
	
	@State private var odometer = "4100"
	@State private var creationDate = Date()
	@State private var fillUpDate = Date()
	@State private var total: Double = 45.0
	@State private var gasPrice: Double = 3.0
	@State private var volume: Double = 15.0
	@State private var gasMileage = 0.0
	@State private var isFilledUp = true
	@State private var isPaidCash = false
	@State private var selectedGasStationName: GasFillEntry.GasStationName = .chevron
	@State private var showAlert = false
		
	private var editorTitle: String {
		entry == nil ? "Add entry" : "Edit entry"
	}
	
	@Environment(\.dismiss) private var dismiss
	@Environment(\.modelContext) private var modelContext
	@Query(fetchDescriptorAll) private var items: [GasFillEntry]
	
    var body: some View {
		ZStack {
			Color.background
				.ignoresSafeArea()
			
			VStack {
				NavigationStack {
					Form {
						Section {
							DatePicker("Fill up date", selection: $fillUpDate)
							
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
									//							.border(.background)
									
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
									validateDate()
									
									if !showAlert {
										calculateGasMileage()
										save()
										dismiss()
									}
								}
							}
							.disabled(odometer == "")
							.alert("Date is not correct",
								   isPresented: $showAlert) {
								Button("Ok", role: .destructive) {
									showAlert.toggle()
								}
							} message: {
								Text("Please, check date or odometer reading")
							}
						}
					}
					.onAppear {
						if let entry {
							odometer = String(entry.odometer)
							fillUpDate = entry.fillUpDate
							total = entry.total
							gasPrice = entry.gasPrice
							volume = entry.volume
							gasMileage = entry.gasMileage
							isFilledUp = entry.isFilledUp
							isPaidCash = entry.isPaidCash
							selectedGasStationName = entry.gasStationName
						}
					}
//					.background(Color.clear)
				}
				.padding()
//				.background(Color.clear)
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
//		else {
//			if isFilledUp {
//				var volumeBetweenFullTankFillUps = volume
//				
//				for item in items {
//					if item.odometer < Int(odometer)! {
//						if item.isFilledUp {
//							gasMileage = Double(Int(odometer)! - item.odometer) / volume
//							break
//						} else {
//							volumeBetweenFullTankFillUps += item.volume
//						}
//					}
//				}
//			}
//			else {
//				for item in items {
//					if (item.odometer < Int(odometer)!){
//						gasMileage = item.gasMileage
//					}
//				}
//			}
//		}
	}
	
	private func validateDate() {
		for item in items {
			if (item.odometer < Int(odometer)!) && (item.fillUpDate > fillUpDate) ||
				(item.odometer > Int(odometer)!) && (item.fillUpDate < fillUpDate) {
				showAlert = true
			}
		}
	}
	
	private func save() {
		if let entry {
			entry.odometer = Int(odometer)!
			entry.fillUpDate = fillUpDate
			entry.total = total
			entry.gasPrice = gasPrice
			entry.volume = volume
			entry.gasMileage = gasMileage
			entry.isFilledUp = isFilledUp
			entry.isPaidCash = isPaidCash
			entry.gasStationName = selectedGasStationName
		} else {
			let newEntry = GasFillEntry(odometer: Int(odometer)!,
										fillUpDate: fillUpDate,
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
