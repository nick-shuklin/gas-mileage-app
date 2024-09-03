import Charts
import SwiftUI
import SwiftData

struct TotalExpensesDetails: View {
	@State private var timeRange: TimeRangeTotalExpensesChart = .last3months
	
	var body: some View {
		VStack(alignment: .leading) {
			TimeRangeTotalExpensesChartPicker(value: $timeRange)
				.padding(.bottom)
			
			switch timeRange {
				case .last3months:
//						Text("adadfads")
//							.font(.title2.bold())
//							.foregroundColor(.primary)
//
//						Text("qewewwqewq")
//							.font(.callout)
//							.foregroundStyle(.secondary)
					
					TotalExpensesChart3months()
				case .ytd:
					TotalExpensesChartYTD()
				case .all:
					TotalExpensesChartAll()
			}
		}			
		.navigationTitle("Total monthly expenses")
		.toolbarTitleDisplayMode(.inline)
	}
}

struct TotalExpensesChart3months: View {
	@Query(fetchDescriptorLast3months) private var items: [GasFillEntry]
	
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

struct TotalExpensesChartYTD: View {
	@Query(fetchDescriptorYTD) private var items: [GasFillEntry]
	
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

struct TotalExpensesChartAll: View {
	@Query(fetchDescriptorAll) private var items: [GasFillEntry]
	
	var body: some View {
		let expenses = groupEntriesByYearAndCalculateTotal(items)
		
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
