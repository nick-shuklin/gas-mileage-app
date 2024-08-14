//
//  ContentView.swift
//  Gas Mileage
//
//  Created by Nick Shuklin on 6/3/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
		TabView {
			MainTab()
				.tabItem {
					Label("Main",
						  systemImage: "house")
				}
			
			ListOfEntriesTab()
				.tabItem {
					Label("Entries",
						  systemImage: "fuelpump")
				}
			
			ChartsTab()
				.tabItem {
					Label("Charts",
						  systemImage: "waveform.and.person.filled")
				}
			
			SettingsTab()
				.tabItem {
					Label("Settings",
						  systemImage: "folder.badge.gearshape")
				}
		}
    }
}

#Preview {
    ContentView()
        .modelContainer(for: GasFillEntry.self, inMemory: false)
		.environment(\.locale, .init(identifier: "ru"))
}
