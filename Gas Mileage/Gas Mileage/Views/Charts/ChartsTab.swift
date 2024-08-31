import SwiftUI

struct ChartsTab: View {
	private enum Destinations {
		case empty
		case gasMileage
		case expenses
	}

	@State private var selection: Destinations?

	var body: some View {
		NavigationSplitView {
			List(selection: $selection) {
				Section {
					NavigationLink(value: Destinations.gasMileage) {
						GasMileageOverview()
					}
				}
				
				Section {
					NavigationLink(value: Destinations.expenses) {
						TotalExpensesOverview()
					}
				}
			}
			.navigationTitle("Charts")
		} detail: {
			NavigationStack {
				switch selection ?? .empty {
					case .empty: Text("Select data to view.")
					case .gasMileage: GasMileageDetails()
					case .expenses: TotalExpensesOverview()
				}
			}
		}
	}
}
