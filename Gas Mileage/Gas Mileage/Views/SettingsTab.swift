import SwiftUI
import SwiftData

struct SettingsTab: View {
	@State private var isMetric = true
	@State private var inProgress = false
	@Query(sort: \GasFillEntry.odometer, order: .forward) var items: [GasFillEntry]
	
    var body: some View {
		VStack {
			Text("Settings")
				.font(.headline)
			
			Form {
				Section() {
					Toggle(String("Recalculate MPG in ALL entries"), isOn: $inProgress)
						.toggleStyle(SwitchToggleStyle(tint: .cyan))
						.onChange(of: inProgress) {
							recalculateGasMileage()
						}
				} header: {
					Text("Utilities")
				} footer: {
					Text("To forcefully recalculate each entry gas mileage data turn on toggle above and wait until it automatically turns back off")
				}
				
				Section("About") {
					Text("Version \(AppVersionProvider.appVersion())")
				}
			}
		}
    }
	
	// TODO: move this outside of the view, add small 0.5 sec delay for animation
	private func recalculateGasMileage() {
		if inProgress {
			var data: (odometer: Int, accumulatedVolume: Double, gasMileage: Double) = (0, 0, 1)
			
			for (i, item) in items.enumerated() {
				if i == 0 {
					item.gasMileage = 1
				} else {
					if item.isFilledUp {
						item.gasMileage = Double(item.odometer - data.odometer) / (data.accumulatedVolume + item.volume)
						data.odometer = item.odometer
						data.accumulatedVolume = 0
						data.gasMileage = item.gasMileage
					} else {
						item.gasMileage = data.gasMileage
						data.accumulatedVolume += item.volume
					}
				}
			}
			
			inProgress.toggle()
		}
	}
}
