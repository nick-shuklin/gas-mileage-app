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
				.accessibilityIdentifier("main_tab")
			
			ListOfEntriesTab()
				.tabItem {
					Label("Entries",
						  systemImage: "fuelpump")
				}
				.accessibilityIdentifier("entries_tab")
			
			ChartsTab()
				.tabItem {
					Label("Charts",
						  systemImage: "waveform.and.person.filled")
				}
				.accessibilityIdentifier("charts_tab")
			
			SettingsTab()
				.tabItem {
					Label("Settings",
						  systemImage: "folder.badge.gearshape")
				}
				.accessibilityIdentifier("settings_tab")
		}
    }
}

#Preview {
    ContentView()
        .modelContainer(for: GasFillEntry.self, inMemory: false)
		.environment(\.locale, .init(identifier: "ru"))
}
