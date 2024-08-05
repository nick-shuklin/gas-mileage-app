import SwiftUI
import SwiftData
import Charts

struct SimpleChartView: View {
	@Environment(\.modelContext) private var modelContext
	@Query(fetchDescriptorAll) private var items: [GasFillEntry]
	
	var gradient: LinearGradient {
		LinearGradient(gradient: Gradient(colors: [.yellow, .green]),
					   startPoint: .top,
					   endPoint: .bottom)
	}
	
    var body: some View {
		VStack(alignment: .leading) {
			Text("Total Sales")
				.font(.callout)
				.foregroundStyle(.secondary)
			
			Text("Gas mileage chart")
				.font(.title2.bold())
			
			Chart {
				ForEach(items) { item in
					BarMark(
						x: .value("Odometer", item.odometer),
						y: .value("Total", item.total)
					)
					.foregroundStyle(gradient)
				}
				RuleMark(y: .value("Average Gas Mileage", 75))
					.foregroundStyle(.red.opacity(0.3))
			}
			.chartScrollableAxes(.horizontal)
			.chartXVisibleDomain(length: 50)
			.chartXScale(domain: 0...30)
			.padding()
//			.chartPlotStyle { plotArea in
//				plotArea
//					.background(.mint.opacity(0.08))
//					.border(.mint)
//			}
		}
    }
}
