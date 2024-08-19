import SwiftUI
import SwiftData

enum TimeRange: Int {
	case last30Days = 30
	case last90Days = 90
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

func predicate(forPeriod: TimeRange = .last30Days) -> Predicate<GasFillEntry> {
	let calendar = Calendar.autoupdatingCurrent
	let end = calendar.startOfDay(for: Date())
	let start = calendar.date(byAdding: .init(day: -forPeriod.rawValue), to: end) ?? end

	return #Predicate<GasFillEntry> { entry in
		(entry.fillUpDate > start && entry.fillUpDate < end)
	}
}

var fetchDescriptor30Days: FetchDescriptor<GasFillEntry> {
	let descriptor = FetchDescriptor<GasFillEntry>(
		predicate: predicate(forPeriod: .last30Days),
		sortBy: [SortDescriptor(\.odometer, order: .reverse)]
	)
	return descriptor
}

var fetchDescriptor90Days: FetchDescriptor<GasFillEntry> {
	let descriptor = FetchDescriptor<GasFillEntry>(
		predicate: predicate(forPeriod: .last90Days),
		sortBy: [SortDescriptor(\.odometer, order: .reverse)]
	)
	return descriptor
}

var fetchDescriptorAll: FetchDescriptor<GasFillEntry> {
	let descriptor = FetchDescriptor<GasFillEntry>(
		sortBy: [SortDescriptor(\.odometer, order: .reverse)]
	)
	return descriptor
}

var fetchDescriptorLast10: FetchDescriptor<GasFillEntry> {
	var descriptor = FetchDescriptor<GasFillEntry>(
		sortBy: [SortDescriptor(\.odometer, order: .reverse)]
	)
	descriptor.fetchLimit = 10
	return descriptor
}

struct backGroundSquareShapedShadow: View {
	let radius: CGFloat = 7
	let modifier: CGFloat = 8

	let innerColor1 = Color(hex: "FFFFFF").opacity(0.64)
	let innerColor2 = Color(hex: "0D2750").opacity(0.16)
	/// B5BFC6 FAFBFF E4EBF1 FFFFFF 6E7F8D 0D2750 161B1D EFF2F9
	var innerBlur1: CGFloat = 43
	var innerBlur2: CGFloat = 48
	var innerXY1: CGFloat = -31
	var innerXY2: CGFloat = 26

	let dropColor1 = Color(hex: "0D2750").opacity(0.16)
	let dropColor2 = Color(hex: "FFFFFF")
	var dropBlur1: CGFloat = 50
	var dropBlur2: CGFloat = 45
	var dropXY1: CGFloat = 28
	var dropXY2: CGFloat = -23

	var body: some View {
		RoundedRectangle(cornerRadius: 5)
			.fill(
				.shadow(.inner(color: innerColor1,
							   radius: innerBlur1/modifier,
							   x: innerXY1/modifier,
							   y: innerXY1/modifier)
				)
				.shadow(.inner(color: innerColor2,
							   radius: innerBlur2/modifier,
							   x: innerXY2/modifier,
							   y: innerXY2/modifier)
				)
				.shadow(.drop(color: dropColor1,
							  radius: dropBlur1/modifier,
							  x: dropXY1/modifier,
							  y: dropXY1/modifier)
				)
				.shadow(.drop(color: dropColor2,
							  radius: dropBlur2/modifier,
							  x: dropXY2/modifier,
							  y: dropXY2/modifier)
				)
			)
			.foregroundColor(Color.background)
	}
}
