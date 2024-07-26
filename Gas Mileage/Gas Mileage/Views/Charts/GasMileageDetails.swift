//
//  GasMileageDetails.swift
//  Gas Mileage
//
//  Created by Nick Shuklin on 7/25/24.
//

import SwiftUI
import Charts
import SwiftData

struct GasMileageDetails: View {
	@State private var timeRange: TimeRange = .last30Days
	
	var body: some View {
		List {
			VStack(alignment: .leading) {
				TimeRangePicker(value: $timeRange)
					.padding(.bottom)
				
				switch timeRange {
					case .last30Days:
						Text("adadfads")
							.font(.title2.bold())
							.foregroundColor(.primary)
						
						Text("qewewwqewq")
							.font(.callout)
							.foregroundStyle(.secondary)
						
						GasMileageChart30Days()
							.frame(height: 240)
					case .last3months:
						<#code#>
					case .last12Months:
						<#code#>
					case .ytd:
						<#code#>
					case .all:
						<#code#>
				}
			}
		}
	}
}

struct GasMileageChart30Days: View {
	@Query(MainView.fetchDescriptor) private var items: [GasFillEntry]
	@Environment(\.modelContext) private var modelContext

	static let amountOfEntriesToDisplay = 10
	static var fetchDescriptor: FetchDescriptor<GasFillEntry> {
		var descriptor = FetchDescriptor<GasFillEntry>(
			predicate: #Predicate { $0.f == true },
			sortBy: [SortDescriptor(\.odometer, order: .reverse)]
		)
		descriptor.fetchLimit = amountOfEntriesToDisplay
		return descriptor
	}
	
	var gradient: LinearGradient {
		LinearGradient(gradient: Gradient(colors: [
			Color(.purple).opacity(0.4),
			Color(.purple).opacity(0.05)
		]),
					   startPoint: .top,
					   endPoint: .bottom
		)
	}
	
	var body: some View {
		
		Chart {
			ForEach(items) { item in
				LineMark(
					x: .value("Date", item.fillUpDate, unit: .day),
					y: .value("Gas mileage", item.gasMileage)
				)
				.lineStyle(StrokeStyle(lineWidth: 1))
				.foregroundStyle(.purple)
				.symbol(Circle())
				
				AreaMark(
					x: .value("Date", item.fillUpDate, unit: .day),
					y: .value("Gas mileage", item.gasMileage)
				)
				.foregroundStyle(gradient)
			}
			.interpolationMethod(.catmullRom)
		}
		.chartScrollableAxes(.horizontal)
		.chartXAxis {
			AxisMarks(values: .stride(by: .month)) { _ in
				AxisGridLine()
				AxisTick()
				AxisValueLabel(format: .dateTime.month(.abbreviated), centered: false)
			}
		}
		.chartYAxis {
			AxisMarks(values: [0, 10, 20, 30, 40]) // TODO: add computed var based of max and min values
		}
		.chartScrollTargetBehavior(
			.valueAligned(
				matching: .init(day: 1)
			)
		)
	}
}
