//
//  SettingsView.swift
//  Gas Mileage
//
//  Created by Nick Shuklin on 6/14/24.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
	@State private var isMetric = true
	@State private var inProgress = false
	
	@Environment(\.modelContext) private var modelContext
	@Query(sort: \GasFillEntry.odometer, order: .reverse) private var items: [GasFillEntry]
	
    var body: some View {
		ZStack {
			Color.background
				.ignoresSafeArea()
			
			VStack {
				Text("Settings")
					.font(.headline)
				
				Form {
					Section() {
						Toggle(isOn: $isMetric) {
							Label("Imperial or Metric",
								  systemImage: isMetric ? "m.square.fill" : "i.square.fill")
						}
						.toggleStyle(SwitchToggleStyle(tint: .cyan))
					} header: {
						Text("Unit settings")
					} footer: {
						Text("Default settings applied based on iPhone settings. Metric: km for odometer, liters per 100km for gas mileage. Imperial: ml and miles per gallon (mpg)")
					}
					
					Section() {
						Toggle(String("Recalculate MPG in ALL entries"), isOn: $inProgress)
							.toggleStyle(SwitchToggleStyle(tint: .cyan))
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
    }
}

#Preview {
	SettingsView()
}
