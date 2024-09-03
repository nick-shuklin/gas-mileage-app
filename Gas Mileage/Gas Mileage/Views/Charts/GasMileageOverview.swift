import Charts
import SwiftUI
import SwiftData

struct GasMileageOverview: View {
	var body: some View {
		VStack(alignment: .center) {
			Text("Gas mileage")
				.font(.callout)
				.foregroundStyle(.secondary)

			GasMileageOverviewChart()
		}
	}
}

struct GasMileageOverviewChart: View {
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
		.chartXAxis(.hidden)
		.chartYAxis(.hidden)
	}
}
