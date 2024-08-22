import SwiftUI

struct EntryRowView: View {
	var item: GasFillEntry
	@Environment(\.locale) var locale: Locale

    var body: some View {
		HStack {
			VStack(alignment: .leading) {
				Text(item.gasStationName.rawValue).bold()
//				Text(item.isPaidCash ? "Cash" : "Card")
				Text(item.isFilledUp ? "Full" : "")
			}
			
			Spacer()
			
			VStack(alignment: .leading) {
				Text(item.fillUpDate, format: Date.FormatStyle(date: .abbreviated, time: .shortened)).bold()
				Text("\(item.odometer) miles")
				Text("$" + String(item.gasPrice.roundTo(places: 2)) + " per gal")
			}
			.lineLimit(1)
			
			Spacer()
			
			VStack(alignment: .leading) {
				Text("$" + String(item.total.roundTo(places: 2)))
				Text(String(item.gasMileage.roundTo(places: 2)) + " mpg").bold()
				Text(String(item.volume.roundTo(places: 2)) + " gal")
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
