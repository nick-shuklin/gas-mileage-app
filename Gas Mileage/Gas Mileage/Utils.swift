import SwiftUI
import SwiftData

// MARK: - Elements to support Gas Mileage charts
enum TimeRangeGasMileageChart {
	case last30Days
	case last90Days
	case last12Months
	case ytd
	case all
}

struct TimeRangeGasMileageChartPicker: View {
	@Binding var value: TimeRangeGasMileageChart

	var body: some View {
		Picker(selection: $value.animation(.easeInOut), label: EmptyView()) {
			Text("30D").tag(TimeRangeGasMileageChart.last30Days)
			Text("90D").tag(TimeRangeGasMileageChart.last90Days)
			Text("12M").tag(TimeRangeGasMileageChart.last12Months)
			Text("YTD").tag(TimeRangeGasMileageChart.ytd)
			Text("ALL").tag(TimeRangeGasMileageChart.all)
		}
		.pickerStyle(.palette)
	}
}

// MARK: - Elements to support Total Expenses charts
enum TimeRangeTotalExpensesChart {
	case last3months
	case ytd
	case all
}

struct TimeRangeTotalExpensesChartPicker: View {
	@Binding var value: TimeRangeTotalExpensesChart

	var body: some View {
		Picker(selection: $value.animation(.bouncy), label: EmptyView()) {
			Text("3M").tag(TimeRangeTotalExpensesChart.last3months)
			Text("YTD").tag(TimeRangeTotalExpensesChart.ytd)
			Text("ALL").tag(TimeRangeTotalExpensesChart.all)
		}
		.pickerStyle(.palette)
	}
}

func predicateForPeriod(ofDays days: Int = 30) -> Predicate<GasFillEntry> {
	let calendar = Calendar.autoupdatingCurrent
	let end = calendar.startOfDay(for: Date())
	let start = calendar.date(byAdding: .init(day: -days), to: end) ?? end

	return #Predicate<GasFillEntry> { entry in
		(entry.fillUpDate > start && entry.fillUpDate < end)
	}
}

// MARK: - Fetch descriptors
// MARK: descriptors to support Gas Mileage charts
var fetchDescriptor30Days: FetchDescriptor<GasFillEntry> {
	let descriptor = FetchDescriptor<GasFillEntry>(
		predicate: predicateForPeriod(ofDays: 30),
		sortBy: [SortDescriptor(\.odometer, order: .reverse)]
	)
	return descriptor
}

var fetchDescriptor90Days: FetchDescriptor<GasFillEntry> {
	let descriptor = FetchDescriptor<GasFillEntry>(
		predicate: predicateForPeriod(ofDays: 90),
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

// MARK: descriptors to support Total Expenses charts
var fetchDescriptorLast3months: FetchDescriptor<GasFillEntry> {
	let calendar = Calendar.autoupdatingCurrent
	let today = Date()
	var numberOfDays: Int? = 0

	if let twoMonthsBack = calendar.date(byAdding: .month, value: -2, to: today) {
		if let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: twoMonthsBack)) {
			numberOfDays = calendar.dateComponents([.day], from: firstDayOfMonth, to: today).day
			print("Number of days between today and the first day of the month two months back: \(numberOfDays!)")
		}
	}
	
	let descriptor = FetchDescriptor<GasFillEntry>(
		predicate: predicateForPeriod(ofDays: numberOfDays!),
		sortBy: [SortDescriptor(\.odometer, order: .reverse)]
	)
	return descriptor
}

var fetchDescriptorYTD: FetchDescriptor<GasFillEntry> {
	let calendar = Calendar.autoupdatingCurrent
	let today = Date()
	var numberOfDays: Int? = 0

	if let twoMonthsBack = calendar.date(byAdding: .month, value: -2, to: today) {
		if let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year], from: twoMonthsBack)) {
			numberOfDays = calendar.dateComponents([.day], from: firstDayOfMonth, to: today).day
		}
	}
	
	let descriptor = FetchDescriptor<GasFillEntry>(
		predicate: predicateForPeriod(ofDays: numberOfDays!),
		sortBy: [SortDescriptor(\.odometer, order: .reverse)]
	)
	return descriptor
}

// MARK: - Grouping values
func groupEntriesByMonthAndCalculateTotal(_ items: [GasFillEntry]) -> [Date: Double] {
	var monthlyTotals: [Date: Double] = [:]

	let calendar = Calendar.current
	for item in items {
		if let monthDate = calendar.date(from: calendar.dateComponents([.year, .month], from: item.fillUpDate)) {
			monthlyTotals[monthDate, default: 0.0] += item.total
		}
	}

	return monthlyTotals
}

func groupEntriesByYearAndCalculateTotal(_ items: [GasFillEntry]) -> [Date: Double] {
	var yearlyTotals: [Date: Double] = [:]

	let calendar = Calendar.current
	for item in items {
		if let yearDate = calendar.date(from: calendar.dateComponents([.year], from: item.fillUpDate)) {
			yearlyTotals[yearDate, default: 0.0] += item.total
		}
	}

	return yearlyTotals
}

// MARK: - UI elements
struct backGroundSquareShapedShadow: View {
	let radius: CGFloat = 7
	let modifier: CGFloat = 9

	let innerColor1 = Color(hex: "FFFFFF").opacity(0.64)
	let innerColor2 = Color(hex: "0D2750").opacity(0.16)
	/// B5BFC6 FAFBFF E4EBF1 FFFFFF 6E7F8D 0D2750 161B1D EFF2F9
	var innerBlur1: CGFloat = 43
	var innerBlur2: CGFloat = 48
	var innerXY1: CGFloat = -31
	var innerXY2: CGFloat = 26

	let dropColor1 = Color(hex: "0D2750").opacity(0.16)
	let dropColor2 = Color(hex: "FFFFFF")
	let dropBlur1: CGFloat = 50
	let dropBlur2: CGFloat = 45
	let dropXY1: CGFloat = 28
	let dropXY2: CGFloat = -23

	var body: some View {
		RoundedRectangle(cornerRadius: 5)
			.fill(
				.shadow(.drop(color: innerColor1,
							   radius: innerBlur1/modifier,
							   x: innerXY1/modifier,
							   y: innerXY1/modifier)
				)
				.shadow(.drop(color: innerColor2,
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

var chartsGradient: LinearGradient {
	LinearGradient(gradient: Gradient(colors: [
		Color(.purple).opacity(0.4),
		Color(.purple).opacity(0.05)
	]),
				   startPoint: .top,
				   endPoint: .bottom
	)
}

//struct BackgroundColorStyle: ViewModifier {
//	@Environment (\.colorScheme) var colorScheme:ColorScheme
//	
//	func body(content: Content) -> some View {
//		if colorScheme == .light {
//			return content
//				.background(Color.gray)
//		} else {
//			return content
//				.background(Color.white)
//		}
//	}
//}
