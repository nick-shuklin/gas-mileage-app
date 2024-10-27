import SwiftUI

struct ShortEntryRowView: View {
	var item: GasFillEntry
	
	var body: some View {
		HStack {
			LogoView(logoName: item.gasStationName.rawValue)
				.accessibilityIdentifier("short_entry_row_logo_\(item.odometer)")
			Spacer()
			Text(item.creationDate, 
				 format: Date.FormatStyle(date: .numeric, time: .none))
				.bold()
				.lineLimit(1)
				.accessibilityIdentifier("short_entry_row_creation_date_\(item.odometer)")
			Spacer()
			Text("$" + String(item.gasPrice.roundTo(places: 2)) + "/gal")
				.accessibilityIdentifier("short_entry_row_price_\(item.odometer)")
			Spacer()
			Text("$" + String(item.total.roundTo(places: 2)))
				.accessibilityIdentifier("short_entry_row_total_\(item.odometer)")
		}
		.font(.caption)
	}
}

#Preview {
	ShortEntryRowView(item: GasFillEntry())
		.modelContainer(for: GasFillEntry.self, inMemory: true)
}
