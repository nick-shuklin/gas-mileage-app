import Charts
import SwiftUI
import SwiftData

struct TotalExpensesOverview: View {	
	var body: some View {
		VStack(alignment: .center) {
			Text("Total monthly expenses")
				.font(.callout)
				.foregroundStyle(.secondary)

			TotalExpensesOverviewChart()
		}
	}
}

struct TotalExpensesOverviewChart: View {
	@Query(fetchDescriptorLast3months) var items: [GasFillEntry]
	
	var body: some View {
		let expenses = groupEntriesByMonthAndCalculateTotal(items)
		
		Chart {
			ForEach(expenses, id: \.month) { (month, total) in
				SectorMark(
					angle: .value("Amount", total),
					innerRadius: .ratio(0.6),
					angularInset: 2
				)
				.foregroundStyle(by: .value("Month", monthFormatted(month)))
				.cornerRadius(5)
			}
		}
		.chartLegend(.hidden)
		.chartXAxis(.hidden)
		.chartYAxis(.hidden)
	}
}
