//
//  ShortEntryRowView.swift
//  Gas Mileage
//
//  Created by Nick Shuklin on 6/21/24.
//

import SwiftUI

struct ShortEntryRowView: View {
	var item: GasFillEntry
	let frameHeight: CGFloat = 36
	let radius: CGFloat = 7
	let modifier: CGFloat = 11
	
	let innerColor1 = Color(hex: "FFFFFF").opacity(0.64)
	let innerColor2 = Color(hex: "0D2750").opacity(0.16)
	/// B5BFC6 FAFBFF E4EBF1 FFFFFF 6E7F8D 0D2750 161B1D EFF2F9
	@State private var innerBlur1: CGFloat = 43
	@State private var innerBlur2: CGFloat = 48
	@State private var innerXY1: CGFloat = -31
	@State private var innerXY2: CGFloat = 26
	
	let dropColor1 = Color(hex: "0D2750").opacity(0.16)
	let dropColor2 = Color(hex: "FFFFFF")
	@State private var dropBlur1: CGFloat = 50
	@State private var dropBlur2: CGFloat = 45
	@State private var dropXY1: CGFloat = 28
	@State private var dropXY2: CGFloat = -23
	
	var body: some View {
		HStack {
			Spacer()
			Text("Logo") // here will be a small gas station logo pic
			Spacer()
			Text(item.creationDate, format: Date.FormatStyle(date: .abbreviated, time: .shortened))
				.bold()
				.lineLimit(1)
			Spacer()
			Text("$" + String(item.gasPrice.roundTo(places: 2)) + "/gal")
			Spacer()
			Text("$" + String(item.total.roundTo(places: 2)))
			Spacer()
		}
		.font(.caption)
		.listRowSeparator(.hidden)
		.frame(height: frameHeight)
		.background(
			RoundedRectangle(cornerRadius: frameHeight/3)
				.fill(
//					.shadow(.inner(color: innerColor1,
//								   radius: innerBlur1/modifier,
//								   x: innerXY1/modifier, y: innerXY1/modifier))
//					.shadow(.inner(color: innerColor2,
//								   radius: innerBlur2/modifier,
//								   x: innerXY2/modifier, y: innerXY2/modifier))
					.shadow(.drop(color: dropColor1,
								  radius: dropBlur1/modifier,
								  x: dropXY1/modifier, y: dropXY1/modifier))
					.shadow(.drop(color: dropColor2,
								  radius: dropBlur2/modifier,
								  x: dropXY2/modifier, y: dropXY2/modifier))
				)
				.foregroundColor(Color.background)
//				.onLongPressGesture {
//					withAnimation(.linear(duration: 2.5)) {
//						dropBlur1 /= 100
//						dropBlur2 /= 100
//						innerBlur1 *= 100
//						innerBlur2 *= 100
//					}
//				}
		)
	}
}

#Preview {
	ShortEntryRowView(item: GasFillEntry())
		.modelContainer(for: GasFillEntry.self, inMemory: true)
}
