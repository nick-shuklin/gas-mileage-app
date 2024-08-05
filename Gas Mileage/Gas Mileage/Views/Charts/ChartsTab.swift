import SwiftUI

struct ChartsTab: View {
	private enum Destinations {
		case empty
		case gasMileage
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
			}
			.navigationTitle("Charts")
		} detail: {
			NavigationStack {
				switch selection ?? .empty {
				case .empty: Text("Select data to view.")
				case .gasMileage: GasMileageDetails()
				}
			}
		}
	}
}
