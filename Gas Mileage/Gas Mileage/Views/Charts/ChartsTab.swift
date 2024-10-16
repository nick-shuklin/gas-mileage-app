import SwiftUI

struct ChartsTab: View {
	let overviewFrameHeight: CGFloat = 180
	let detailsFrameHeight: CGFloat = 360
	
	// FIXME: replace this approach with apple suggested solution
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
							.frame(height: overviewFrameHeight)
					}
				}
				
				Section {
					NavigationLink(value: Destinations.expenses) {
						TotalExpensesOverview()
							.frame(height: overviewFrameHeight)
					}
				}
			}
			.navigationTitle("Charts")
			.toolbarTitleDisplayMode(.inline)
		} detail: {
			NavigationStack {
				switch selection ?? .empty {
					case .empty: 
						Text("Select data to view.")
					case .gasMileage: 
						GasMileageDetails()
							.frame(height: detailsFrameHeight)
							.padding()
					case .expenses:
						TotalExpensesDetails()
							.frame(height: detailsFrameHeight)
							.padding()
				}
			}
		}
	}
}
