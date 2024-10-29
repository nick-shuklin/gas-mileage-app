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
				Text(item.gasStationName.rawValue)
			}
			
			Section {
				VStack {
					DetailRow(label: "Odometer", value: "\(item.odometer) miles")
					DetailRow(label: "Total", value: "$\(item.total.roundTo(places: 2))")
					DetailRow(label: "Price", value: "$\(item.gasPrice.roundTo(places: 2)) per gal")
					DetailRow(label: "Volume", value: "\(item.volume.roundTo(places: 2)) gal")
					DetailRow(label: "Gas mileage", value: "\(item.gasMileage.roundTo(places: 2)) mpg")
				}
			}
			
			Section {
				Toggle(String("Tank filled up?"), isOn: $item.isFilledUp)
			}
		}
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
