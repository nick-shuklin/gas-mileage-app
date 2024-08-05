//
//  GasMileageOverview.swift
//  Gas Mileage
//
//  Created by Nikolay Shuklin on 8/5/24.
//

import Charts
import SwiftUI
import SwiftData

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

struct GasMileageOverview: View {
	var body: some View {
		VStack(alignment: .leading) {
			Text("Gas mileage")
				.font(.callout)
				.foregroundStyle(.secondary)

			GasMileageOverviewChart()
				.frame(height: 100)
		}
	}
}

#Preview {
	GasMileageOverview()
		.modelContainer(for: GasFillEntry.self, inMemory: false)
}
