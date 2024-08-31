import SwiftUI
import Charts
import SwiftData

struct ChartsView: View {
	@Query(fetchDescriptorAll) private var items: [GasFillEntry]
	
	var body: some View {
		ZStack {
			Color.background
				.ignoresSafeArea()
			
			VStack {
				Text("Charts")
					.font(.headline)
				
				Section() {
//					Text("Gas mileage")
//						.font(.callout)
//						.foregroundStyle(.secondary)
//
//					Text("Gas mileage chart")
//						.font(.title2.bold())
					
				GasMileageDetails()
//				Chart {
//					ForEach(items) { item in
//						BarMark(
//							x: .value("Date", item.fillUpDate),
//							y: .value("Gas mileage", item.gasMileage)
//						)
//					}
//					.foregroundStyle(.green)
//				}
//				.chartScrollableAxes(.horizontal)
////				.chartXVisibleDomain(length: 3600 * 24 * 30)
//				.chartScrollPosition(x: $scrollPosition)
//				.chartScrollTargetBehavior(
//					.valueAligned(
//						matching: DateComponents(hour: 0),
//						majorAlignment: .matching(DateComponents(day: 1))
//					)
//				)
//				.padding()
					
//					Chart(items) {
//						LineMark (
//							x: .value("Date", $0.fillUpDate),
//							y: .value("Gas mileage", $0.gasMileage)
//						)
//						.interpolationMethod(.monotone)
//					}
//					.chartScrollableAxes(.horizontal)
//					.chartXVisibleDomain(length: 3600 * 24 * 30)
//					.padding()
				}
//				.background(
//					RoundedRectangle(cornerRadius: 20)
//						.fill(
//							.shadow(.drop(color: dropColor1,
//										  radius: dropBlur1/modifier,
//										  x: dropXY1/modifier,
//										  y: dropXY1/modifier))
//							.shadow(.drop(color: dropColor2,
//										  radius: dropBlur2/modifier,
//										  x: dropXY2/modifier,
//										  y: dropXY2/modifier))
//						)
//						.foregroundColor(Color.background)
//				)
				
//				Section {
//					Chart {
//						ForEach(items) { item in
//							BarMark(
//								x: .value("Date", item.fillUpDate),
//								y: .value("Volume", item.volume)
//							)
//						}
//					}
//					.padding()
//				}
//				.background(
//					RoundedRectangle(cornerRadius: 20)
//						.fill(
//							.shadow(.drop(color: dropColor1,
//										  radius: dropBlur1/modifier,
//										  x: dropXY1/modifier,
//										  y: dropXY1/modifier))
//							.shadow(.drop(color: dropColor2,
//										  radius: dropBlur2/modifier,
//										  x: dropXY2/modifier,
//										  y: dropXY2/modifier))
//						)
//						.foregroundColor(Color.background)
//				)
			}
//			.padding()
		}
	}
}
