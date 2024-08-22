import SwiftUI

struct ShortEntryRowView: View {
	var item: GasFillEntry
	
	var body: some View {
		HStack {
			Text("Logo") // here will be a small gas station logo pic
			Spacer()
			Text(item.creationDate, format: Date.FormatStyle(date: .abbreviated, time: .shortened))
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
