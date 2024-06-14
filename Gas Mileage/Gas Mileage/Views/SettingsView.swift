//
//  SettingsView.swift
//  Gas Mileage
//
//  Created by Nick Shuklin on 6/14/24.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
		Form {
			Section("About") {
				Text("Version \(AppVersionProvider.appVersion())")
			}
		}
    }
}
