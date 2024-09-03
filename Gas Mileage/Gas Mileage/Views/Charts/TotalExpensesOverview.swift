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
			ForEach(expenses.keys.sorted(), id: \.self) { date in
				if let amount = expenses[date] {
					SectorMark(
						angle: .value("Amount", amount),
						innerRadius: .ratio(0.6),
						angularInset: 2
					)
					.foregroundStyle(by: .value("Month", date))
					.cornerRadius(5)
				}
			}
		}
		.chartXAxis(.hidden)
		.chartYAxis(.hidden)
	}
}
