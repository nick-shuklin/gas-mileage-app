import SwiftUI
import SwiftData
import Charts

struct MainTab: View {
	@Query(fetchDescriptorLast10) private var items: [GasFillEntry]
	@Environment(\.modelContext) private var modelContext
	
	var body: some View {
		ZStack {
//			Color.background
//				.ignoresSafeArea()

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
