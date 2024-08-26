import SwiftUI
import SwiftData
import Charts

struct MainTab: View {
	@Query(fetchDescriptorLast10) private var items: [GasFillEntry]
	@Environment(\.modelContext) private var modelContext
	
	var body: some View {
		ZStack {
			Color.background
				.ignoresSafeArea()

			VStack {
				Text("Main screen")
					.font(.headline)
				
				GasMileageYTDChartMainTabView()
					.padding()
					.frame(height: 260)
					.background(
						backGroundSquareShapedShadow()
					)
				
				NavigationView {
					ScrollView() {
						Grid(alignment: .trailing) {
							ForEach(items) { item in
								GridRow {
									ShortEntryRowView(item: item)
								}
								.frame(height: 36)
							}
						}
						.padding()
					}
					.toolbar {
						ToolbarItem(placement: .navigationBarLeading) {
							Text("Last 10 entries")
								.font(.subheadline)
						}
					}
					.scrollIndicators(.hidden)
					.background(Color.background)
				}
				.padding(.top, 5)
			}
			.padding()
		}
	}
}

#Preview {
	MainTab()
		.modelContainer(for: GasFillEntry.self, inMemory: false)
}
