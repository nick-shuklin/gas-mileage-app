//
//  Utils.swift
//  Gas Mileage
//
//  Created by Nick Shuklin on 7/13/24.
//

import SwiftUI

enum TimeRange {
	case last30Days
	case last90Days
//	case last12Months
//	case ytd
	case all
}

struct TimeRangePicker: View {
	@Binding var value: TimeRange

	var body: some View {
		Picker(selection: $value.animation(.easeInOut), label: EmptyView()) {
			Text("30D").tag(TimeRange.last30Days)
			Text("90D").tag(TimeRange.last90Days)
//			Text("12M").tag(TimeRange.last12Months)
//			Text("YTD").tag(TimeRange.ytd)
			Text("ALL").tag(TimeRange.all)
		}
		.pickerStyle(.palette)
	}
}

var chartsGradient: LinearGradient {
	LinearGradient(gradient: Gradient(colors: [
		Color(.purple).opacity(0.4),
		Color(.purple).opacity(0.05)
	]),
				   startPoint: .top,
				   endPoint: .bottom
	)
}
