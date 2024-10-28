import SwiftUI

struct EntryRowView: View {
	var item: GasFillEntry
	@Environment(\.locale) var locale: Locale

    var body: some View {
		HStack {
			LogoView(logoName: item.gasStationName.rawValue)
				.accessibilityIdentifier("entry_row_logo_\(item.odometer)")
			Spacer()
			VStack(alignment: .leading) {
				Text(item.fillUpDate,
					 format: Date.FormatStyle(date: .abbreviated,
											  time: .none))
				.bold()
				.accessibilityIdentifier("entry_row_fillupdate_\(item.odometer)")
				Text("\(item.odometer) miles")
					.accessibilityIdentifier("entry_row_odometer_\(item.odometer)")
				Text("$" + String(item.gasPrice.roundTo(places: 2)) + " per gal")
					.accessibilityIdentifier("entry_row_gasprice_\(item.odometer)")
			}
			.lineLimit(1)
			Spacer()
			VStack(alignment: .leading) {
				Text("$" + String(item.total.roundTo(places: 2)))
					.accessibilityIdentifier("entry_row_total_\(item.odometer)")
				Text(String(item.gasMileage.roundTo(places: 2)) + " mpg").bold()
					.accessibilityIdentifier("entry_row_gasmileage_\(item.odometer)")
				Text(String(item.volume.roundTo(places: 2)) + " gal")
					.accessibilityIdentifier("entry_row_volume_\(item.odometer)")
			}
			Spacer()
			Image(systemName: "chevron.right")
				.background(
					backGroundSquareShapedShadow()
						.frame(width: 30, height: 30)
				)
		}
		.font(.caption)
    }
}
