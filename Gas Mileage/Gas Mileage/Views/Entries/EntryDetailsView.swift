import SwiftUI
import SwiftData

struct EntryDetailsView: View {
	@Bindable var item: GasFillEntry
	@State private var showEditEntryView: Bool = false
	@Binding var showTabBar: Bool
	
	var body: some View {
		Form {
			Section {
				Text(item.fillUpDate, format: Date.FormatStyle(date: .abbreviated, time: .shortened))
					.accessibilityIdentifier("fill_up_date")
				Text(item.gasStationName.rawValue)
					.accessibilityIdentifier("gas_station_name")
			}
			
			Section {
				VStack {
					DetailRow(label: "Odometer", value: "\(item.odometer) miles")
						.accessibilityIdentifier("odometer")
					DetailRow(label: "Total", value: "$\(item.total.roundTo(places: 2))")
						.accessibilityIdentifier("total")
					DetailRow(label: "Price", value: "$\(item.gasPrice.roundTo(places: 2)) per gal")
						.accessibilityIdentifier("price")
					DetailRow(label: "Volume", value: "\(item.volume.roundTo(places: 2)) gal")
						.accessibilityIdentifier("volume")
					DetailRow(label: "Gas mileage", value: "\(item.gasMileage.roundTo(places: 2)) mpg")
						.accessibilityIdentifier("gas_mileage")
				}
			}
			
			Section {
				Toggle(String("Tank filled up?"), isOn: $item.isFilledUp)
					.accessibilityIdentifier("tank_filled_toggle")
			}
		}
		.accessibilityIdentifier("list_view")
		.navigationTitle("Entry details") // This approach vs ToolbarItem adds accID to NavigationBar
		.toolbarTitleDisplayMode(.inline)
		.toolbar {
			ToolbarItem(placement: .topBarTrailing) {
				Button {
					showEditEntryView.toggle()
				} label: {
					Label("Edit", systemImage: "edit")
				}
				.accessibilityIdentifier("edit_button")
				.sheet(isPresented: $showEditEntryView) {
					EditEntryView(entry: item)
				}
			}
		}
		.onAppear {
			withAnimation {
				showTabBar.toggle()
			}
		}
		.onDisappear {
			withAnimation {
				showTabBar.toggle()
			}
		}
	}
}

struct DetailRow: View {
	let label: String
	let value: String

	var body: some View {
		HStack {
			Text(label)
			Spacer()
			Text(value)
		}
	}
}
