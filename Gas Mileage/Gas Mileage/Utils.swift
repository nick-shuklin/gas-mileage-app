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
