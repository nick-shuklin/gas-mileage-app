//
//  SettingsView.swift
//  Gas Mileage
//
//  Created by Nick Shuklin on 6/14/24.
//

import SwiftUI

struct SettingsView: View {
	@State private var isMetric = true
	
    var body: some View {
		NavigationStack {
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
					Text("Default setting applied based on iPhone settings. Metric: km for odometer, liters per 100km for gas mileage. Imperial: ml and miles per gallon (mpg)")
				}
				
				Section("About") {
					Text("Version \(AppVersionProvider.appVersion())")
				}
			}
		}
    }
}

#Preview {
	SettingsView()
}
