import SwiftUI

struct ShortEntryRowView: View {
	var item: GasFillEntry
	let logoSize: CGFloat = 36
	
	var body: some View {
		HStack {
			if let uiImage = UIImage(named: item.gasStationName.rawValue) {
				ZStack {
					Color.white
						.frame(width: logoSize, height: logoSize)
						.cornerRadius(5)
							
					Image(uiImage: uiImage)
						.renderingMode(.original)
						.resizable()
						.saturation(0)
						.contrast(0.7)
						.aspectRatio(contentMode: .fit)
						.frame(width: logoSize, height: logoSize)
						.cornerRadius(5)
						.clipped()
				}
			} else {
				Image("Default")
					.resizable()
					.aspectRatio(contentMode: .fit)
					.frame(width: logoSize, height: logoSize)
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
