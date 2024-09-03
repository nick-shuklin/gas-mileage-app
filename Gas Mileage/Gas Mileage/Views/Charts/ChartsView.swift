import SwiftUI
import Charts
import SwiftData

struct ChartsView: View {
	@Query(fetchDescriptorAll) private var items: [GasFillEntry]
	
	var body: some View {
		ZStack {
			Color.background
				.ignoresSafeArea()
			
			VStack {
				Text("Charts")
					.font(.headline)
				
				Section() {
					GasMileageDetails()
				}
			}
		}
	}
}
