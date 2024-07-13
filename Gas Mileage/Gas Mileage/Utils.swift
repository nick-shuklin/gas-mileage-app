//
//  Utils.swift
//  Gas Mileage
//
//  Created by Nick Shuklin on 7/13/24.
//

import SwiftUI

enum TimeRange {
	case last30Days
	case last12Months
	case ytd
}

struct TimeRangePicker: View {
	@Binding var value: TimeRange

	var body: some View {
		Picker(selection: $value.animation(.easeInOut), label: EmptyView()) {
			Text("30 Days").tag(TimeRange.last30Days)
			Text("12 Months").tag(TimeRange.last12Months)
			Text("YTD").tag(TimeRange.ytd)
		}
		.pickerStyle(.segmented)
	}
}
