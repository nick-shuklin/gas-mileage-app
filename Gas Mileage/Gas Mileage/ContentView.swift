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
			MainView()
				.tabItem {
					Label("Main",
						  systemImage: "house")
				}
			
			ListOfEntriesView()
				.tabItem {
					Label("Entries",
						  systemImage: "fuelpump")
				}
			
			ChartsView()
				.tabItem {
					Label("Charts",
						  systemImage: "waveform.and.person.filled")
				}
			
			SettingsView()
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
}
