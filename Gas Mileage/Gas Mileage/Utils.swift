//
//  Utils.swift
//  Gas Mileage
//
//  Created by Nick Shuklin on 7/13/24.
//

import SwiftUI

enum TimeRange {
	case last30Days
	case last3months
	case last12Months
	case ytd
	case all
}

struct TimeRangePicker: View {
	@Binding var value: TimeRange

	var body: some View {
		Picker(selection: $value.animation(.easeInOut), label: EmptyView()) {
			Text("30D").tag(TimeRange.last30Days)
			Text("3M").tag(TimeRange.last3months)
			Text("12M").tag(TimeRange.last12Months)
			Text("YTD").tag(TimeRange.ytd)
			Text("ALL").tag(TimeRange.all)
		}
		.pickerStyle(.palette)
	}
}
