import SwiftUI
import Charts
import SwiftData

struct GasMileageDetails: View {
	@State private var timeRange: TimeRangeGasMileageChart = .last30Days
	
	var body: some View {
		VStack() {
			TimeRangeGasMileageChartPicker(value: $timeRange)
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
				case .last90Days:
					GasMileageChart90Days()
				default:
					GasMileageChartAll()
			}
		}
		.navigationTitle("Gas mileage")
		.toolbarTitleDisplayMode(.inline)
	}
}

struct GasMileageChart30Days: View {
	@Query(fetchDescriptor30Days) private var items: [GasFillEntry]
	
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
			AxisMarks(position: .leading, values: .automatic(desiredCount: 3))
		}
		// This should be optional depending on amount of entries
//		.chartScrollableAxes(.horizontal)
//		.chartXVisibleDomain(length: 3600 * 24 * 15)
	}
}

struct GasMileageChart90Days: View {
	@Query(fetchDescriptor90Days) private var items: [GasFillEntry]
	
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
	@Query(fetchDescriptorAll) private var items: [GasFillEntry]
	
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
				if let date = value.as(Date.self) {
					let month = Calendar.current.component(.month, from: date)
					AxisValueLabel {
						VStack(alignment: .leading) {
							Text(date, format: .dateTime.month())
							
							if value.index == 0 || month == 1 {
								Text(date, format: .dateTime.year())
							}
						}
					}
					
					AxisGridLine()
					AxisTick()
				}
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
