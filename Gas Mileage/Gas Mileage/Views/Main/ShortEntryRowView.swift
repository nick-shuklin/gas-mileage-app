import SwiftUI

struct ShortEntryRowView: View {
	var item: GasFillEntry
	
	var body: some View {
		HStack {
			if let uiImage = UIImage(named: item.gasStationName.rawValue) {
				Image(uiImage: uiImage)
					.resizable()
					.aspectRatio(contentMode: .fit)
					.frame(width: 30, height: 30)
					.cornerRadius(5)
			} else {
				Image("Default")
					.resizable()
					.aspectRatio(contentMode: .fit)
					.frame(width: 30, height: 30)
					.cornerRadius(5)
			}
			Spacer()
			Text(item.creationDate, format: Date.FormatStyle(date: .numeric, time: .shortened))
				.bold()
				.lineLimit(1)
			Spacer()
			Text("$" + String(item.gasPrice.roundTo(places: 2)) + "/gal")
			Spacer()
			Text("$" + String(item.total.roundTo(places: 2)))
		}
		.font(.caption)
	}
}

#Preview {
	ShortEntryRowView(item: GasFillEntry())
		.modelContainer(for: GasFillEntry.self, inMemory: true)
}
