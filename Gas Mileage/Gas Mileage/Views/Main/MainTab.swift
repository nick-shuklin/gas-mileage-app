import SwiftUI
import SwiftData
import Charts

struct MainTab: View {
	@Query(MainTab.fetchDescriptor) private var items: [GasFillEntry]
	@Environment(\.modelContext) private var modelContext
	
	static let amountOfEntriesToDisplay = 10
	static var fetchDescriptor: FetchDescriptor<GasFillEntry> {
		var descriptor = FetchDescriptor<GasFillEntry>(
			predicate: #Predicate { $0.isPaidCash == true },
			sortBy: [SortDescriptor(\.odometer, order: .reverse)]
		)
		descriptor.fetchLimit = amountOfEntriesToDisplay
		return descriptor
	}
	
	var body: some View {
		ZStack {
			Color.background
				.ignoresSafeArea()

			VStack {
				Text("Main screen")
					.font(.headline)
				
				SimpleChartView()
					.frame(height: 280) // adjust height to the screen size
					.padding()
				
				ScrollView() {
					Grid(alignment: .trailing) {
						ForEach(items) { item in
							GridRow {
								ShortEntryRowView(item: item)
							}
						}
					}
					.padding()
				}
				.scrollIndicators(.hidden)
			}
		}
	}
}

#Preview {
	MainTab()
		.modelContainer(for: GasFillEntry.self, inMemory: false)
}
