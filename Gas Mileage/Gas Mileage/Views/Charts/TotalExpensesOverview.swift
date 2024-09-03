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
//	let expenses: [Date : Double] = [
//		Date.now : 34.5,
//		Calendar.current.date(byAdding: .day, value: -30, to: Date.now)!  : 23.6,
//		Calendar.current.date(byAdding: .day, value: -62, to: Date.now)! : 67.8
//	]
	
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

//#Preview {
//	TotalExpensesOverviewChart()
//		.modelContainer(for: GasFillEntry.self, inMemory: false)
//}
