import Charts
import SwiftUI
import SwiftData

struct TotalExpensesDetails: View {
	@State private var timeRange: TimeRangeTotalExpensesChart = .last3months
	@Query(fetchDescriptorLast3months) private var items: [GasFillEntry]
	
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
					
					TotalExpensesChart3months(expenses: groupEntriesByMonthAndCalculateTotal(items))
				case .ytd:
					TotalExpensesChartYTD()
				case .all:
					TotalExpensesChartAll()
			}
			
			Spacer()
		}
		.navigationTitle("Total monthly expenses")
		.toolbarTitleDisplayMode(.inline)
	}
}

// TODO: all 3 charts can be gathered in one struct
struct TotalExpensesChart3months: View {
	@Query(fetchDescriptorLast3months) private var items: [GasFillEntry]
	let expenses: [(month: Date, total: Double)]
	
	@State var selectedMonth: Date? = nil
	
	var selectedExpense: (month: Date, total: Double)? {
		if let selectedMonth {
			return expenses.first { $0.month == selectedMonth }
		}
		return nil
	}
	
	var body: some View {
		ZStack {
			Chart {
				ForEach(expenses, id: \.month) { element in
					SectorMark(
						angle: .value("Total", element.total),
						innerRadius: .ratio(0.6),
						angularInset: 1.5
					)
					.cornerRadius(5.0)
					.foregroundStyle(by: .value("Month", monthFormatted(element.month)))
//					.opacity(selectedMonth == nil || selectedMonth == element.month ? 1 : 0.3) // Highlight selected sector
//					.onTapGesture {
//							// Toggle selection
//							selectedMonth = (selectedMonth == element.month) ? nil : element.month
//						}
				}
			}
			.chartLegend(alignment: .center, spacing: 18)
			.chartAngleSelection(value: $selectedMonth) // Selection based on angle
			.scaledToFit()

			// Display selected month and total expenses in the center of the chart
//			if let selectedExpense = selectedExpense {
//				VStack {
//					Text(monthFormatted(selectedExpense.month))
//						.font(.title2.bold())
//						.foregroundColor(.primary)
//					Text("\(selectedExpense.total.formatted()) total")
//						.font(.callout)
//						.foregroundStyle(.secondary)
//				}
//				.padding()
//				.background(Color.white.opacity(0.8)) // Background for better readability
//				.cornerRadius(10)
//				.shadow(radius: 5)
//				.position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 4)
//			}
		}
	}
}

struct TotalExpensesChartYTD: View {
	@Query(fetchDescriptorYTD) private var items: [GasFillEntry]
	
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
		.chartLegend(alignment: .bottom)
	}
}

struct TotalExpensesChartAll: View {
	@Query(fetchDescriptorAll) private var items: [GasFillEntry]
	
	var body: some View {
		let expenses = groupEntriesByYearAndCalculateTotal(items)
		
		Chart {
			ForEach(expenses, id: \.year) { (year, total) in
				SectorMark(
					angle: .value("Amount", total),
					innerRadius: .ratio(0.6),
					angularInset: 2
				)
				.foregroundStyle(by: .value("Month", yearFormatted(year)))
				.cornerRadius(5)
			}
		}
		.chartLegend(alignment: .bottom)
	}
}
