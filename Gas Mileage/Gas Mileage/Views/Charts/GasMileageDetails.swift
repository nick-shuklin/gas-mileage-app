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
//						Text("adadfads")
//							.font(.title2.bold())
//							.foregroundColor(.primary)
//						
//						Text("qewewwqewq")
//							.font(.callout)
//							.foregroundStyle(.secondary)
						
						GasMileageChart30Days()
							.frame(height: 240)
					case .last90Days:
						GasMileageChart90Days()
							.frame(height: 240)
					default:
						GasMileageChartAll()
							.frame(height: 240)
				}
			}
		}
	}
}

struct GasMileageChart30Days: View {
	@Query(GasMileageChart30Days.fetchDescriptor) private var items: [GasFillEntry]

	static func predicate() -> Predicate<GasFillEntry> {
		let calendar = Calendar.autoupdatingCurrent
		let end = calendar.startOfDay(for: Date())
		let start = calendar.date(byAdding: .init(day: -30), to: end) ?? end
	
		return #Predicate<GasFillEntry> { entry in
			(entry.fillUpDate > start && entry.fillUpDate < end)
		}
	}
	
	static var fetchDescriptor: FetchDescriptor<GasFillEntry> {
		let descriptor = FetchDescriptor<GasFillEntry>(
			predicate: predicate(),
			sortBy: [SortDescriptor(\.odometer, order: .reverse)]
		)
		return descriptor
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
				.foregroundStyle(chartsGradient)
			}
			.interpolationMethod(.catmullRom)
		}
		.chartXAxis {
			AxisMarks(values: .stride(by: .day, count: 7)) { _ in
				AxisGridLine()
				AxisTick()
				AxisValueLabel(format: .dateTime.month().day(), centered: false)
			}
		}
		.chartYAxis {
			AxisMarks(values: [0, 10, 20, 30, 40]) // TODO: add computed var based of max and min values
		}
		// This should be optional depending on amount of entries
//		.chartScrollableAxes(.horizontal)
//		.chartXVisibleDomain(length: 3600 * 24 * 15)
	}
}

struct GasMileageChart90Days: View {
	@Query(GasMileageChart90Days.fetchDescriptor) private var items: [GasFillEntry]

	static func predicate() -> Predicate<GasFillEntry> {
		let calendar = Calendar.autoupdatingCurrent
		let end = calendar.startOfDay(for: Date())
		let start = calendar.date(byAdding: .init(day: -90), to: end) ?? end
	
		return #Predicate<GasFillEntry> { entry in
			(entry.fillUpDate > start && entry.fillUpDate < end)
		}
	}
	
	static var fetchDescriptor: FetchDescriptor<GasFillEntry> {
		let descriptor = FetchDescriptor<GasFillEntry>(
			predicate: predicate(),
			sortBy: [SortDescriptor(\.odometer, order: .reverse)]
		)
		return descriptor
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
				.foregroundStyle(chartsGradient)
			}
			.interpolationMethod(.catmullRom)
		}
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
				matching: .init(day: 1),
				majorAlignment: .matching(.init(month: 1))
			)
		)
		.chartScrollableAxes(.horizontal)
		.chartXVisibleDomain(length: 3600 * 24 * 90)
	}
}

struct GasMileageChartAll: View {
	@Query(sort: \GasFillEntry.odometer, order: .reverse) private var items: [GasFillEntry]
	
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
				.foregroundStyle(chartsGradient)
			}
			.interpolationMethod(.catmullRom)
		}
		.chartScrollableAxes(.horizontal)
		.chartXAxis {
			AxisMarks(values: .stride(by: .month)) { value in
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
