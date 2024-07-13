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
						  systemImage: "house.circle.fill")
				}
			
			ListOfEntriesView()
				.tabItem {
					Label("Entries",
						  systemImage: "fuelpump.circle")
				}
			
			ChartsView()
				.tabItem {
					Label("Graphs",
						  systemImage: "waveform.circle")
				}
			
			SettingsView()
				.tabItem {
					Label("Settings",
						  systemImage: "gear")
				}
		}
    }
}

#Preview {
    ContentView()
        .modelContainer(for: GasFillEntry.self, inMemory: true)
}
