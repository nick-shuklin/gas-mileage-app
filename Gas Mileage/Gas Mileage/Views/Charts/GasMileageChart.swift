//
//  GasMileageChart.swift
//  Gas Mileage
//
//  Created by Nick Shuklin on 7/25/24.
//

import SwiftUI
import Charts
import SwiftData

struct GasMileageChart: View {
	@Environment(\.modelContext) private var modelContext
	@Query(sort: \GasFillEntry.odometer, order: .reverse) private var items: [GasFillEntry]
	
	var gradient: LinearGradient {
		LinearGradient(gradient: Gradient(colors: [
			Color(.purple).opacity(0.4),
			Color(.purple).opacity(0.05)
		]),
					   startPoint: .top,
					   endPoint: .bottom
		)
	}
	
	var title: some View {
		VStack(alignment: .leading) {
			Text("Gas mileage")
				.font(.title2.bold())
				.foregroundStyle(.secondary)
			Text("Sundays in San Francisco")
				.font(.callout)
		}
	}
	
	var body: some View {
		Chart {
			ForEach(items) { item in
				LineMark(
					x: .value("Date", item.timeOfFillUp, unit: .day),
					y: .value("Gas mileage", item.gasMileage)
				)
				.foregroundStyle(.purple)
				.symbol(Circle())
				
				AreaMark(
					x: .value("Date", item.timeOfFillUp, unit: .day),
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
			AxisMarks(values: [0, 10, 20, 30, 40, 50]) // TODO: add computed var based of max and min values
		}
		.chartScrollTargetBehavior(
			.valueAligned(
				matching: .init(day: 1)
			)
		)
	}
}
