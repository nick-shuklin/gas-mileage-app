import SwiftUI
import SwiftData
import Charts

struct MainTab: View {
	@Query(fetchDescriptorLast10) private var items: [GasFillEntry]
	@Environment(\.modelContext) private var modelContext

	var body: some View {
		NavigationView {
			VStack(alignment: .leading) {
				GasMileageYTDChartMainTabView()
					.padding(.horizontal)
					.frame(height: 260)

				Text("Last 10 entries")
					.font(.subheadline)
					.padding(.horizontal)
					.padding(.top, 16)
					.accessibilityIdentifier("last_10_entries_label")

				ScrollView {
					Grid(alignment: .trailing) {
						ForEach(items) { item in
							VStack {
								GridRow {
									ShortEntryRowView(item: item)
								}
								.frame(height: 36)
							}
							.accessibilityElement(children: .ignore) // This will add IUview wrapper for each row
						}
					}
					.padding(.horizontal)
				}
				.scrollIndicators(.hidden)
				.accessibilityIdentifier("scroll_view")
			}
			.padding(.bottom, 16)
			.navigationTitle("Main Screen")
			.navigationBarTitleDisplayMode(.inline)
		}
		.accessibilityIdentifier("navigation_view")
	}
}

#Preview {
	MainTab()
		.modelContainer(for: GasFillEntry.self, inMemory: false)
}
