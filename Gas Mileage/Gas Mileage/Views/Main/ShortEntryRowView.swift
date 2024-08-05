import SwiftUI

struct ShortEntryRowView: View {
	var item: GasFillEntry
	let frameHeight: CGFloat = 36
	
	var body: some View {
		HStack {
			Spacer()
			Text("Logo") // here will be a small gas station logo pic
			Spacer()
			Text(item.creationDate, format: Date.FormatStyle(date: .abbreviated, time: .shortened))
				.bold()
				.lineLimit(1)
			Spacer()
			Text("$" + String(item.gasPrice.roundTo(places: 2)) + "/gal")
			Spacer()
			Text("$" + String(item.total.roundTo(places: 2)))
			Spacer()
		}
		.font(.caption)
		.listRowSeparator(.hidden)
		.frame(height: frameHeight)
	}
}

#Preview {
	ShortEntryRowView(item: GasFillEntry())
		.modelContainer(for: GasFillEntry.self, inMemory: true)
}
