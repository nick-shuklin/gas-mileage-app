//
//  ChartsView.swift
//  Gas Mileage
//
//  Created by Nick Shuklin on 6/14/24.
//

import SwiftUI
import Charts
import SwiftData

struct ChartsView: View {
	
//	let radius: CGFloat = 7
//	let modifier: CGFloat = 7
//	
//	let innerColor1 = Color(hex: "FFFFFF").opacity(0.64)
//	let innerColor2 = Color(hex: "0D2750").opacity(0.16)
//	/// B5BFC6 FAFBFF E4EBF1 FFFFFF 6E7F8D 0D2750 161B1D EFF2F9
//	@State private var innerBlur1: CGFloat = 43
//	@State private var innerBlur2: CGFloat = 48
//	@State private var innerXY1: CGFloat = -31
//	@State private var innerXY2: CGFloat = 26
//	
//	let dropColor1 = Color(hex: "0D2750").opacity(0.16)
//	let dropColor2 = Color(hex: "FFFFFF")
//	@State private var dropBlur1: CGFloat = 50
//	@State private var dropBlur2: CGFloat = 45
//	@State private var dropXY1: CGFloat = 28
//	@State private var dropXY2: CGFloat = -23
	
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

//#Preview {
//	ChartsView()
//		.modelContainer(for: GasFillEntry.self, inMemory: false)
//}
