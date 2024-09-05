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

// TODO: all 3 charts can be gathered in one struct
struct TotalExpensesChart3months: View {
	@Query(fetchDescriptorLast3months) private var items: [GasFillEntry]
	
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
