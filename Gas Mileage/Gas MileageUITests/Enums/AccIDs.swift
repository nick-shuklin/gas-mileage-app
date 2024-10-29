enum AccIDs {
	enum MainScreen: String {
		case mainTabView = "main_tab"
		case chartView = "ytd_chart_view"
		case scrollView = "scroll_view"
		case last10EntriesLabel = "last_10_entries_label"
	}
	
	enum EntriesScreen: String {
		case entriesTabView = "entries_tab"
		case addEntryButton = "add_entry_button"
		case generateEntryButton = "generate_entry_button"
		case editEntryButton = "edit_button"
		case removeImage = "minus.circle.fill"
	}
	
	enum TabBar: String {
		case mainTabBarButton = "house"
		case entriesTabBarButton = "fuelpump"
		case chartsTabBarButton = "waveform.and.person.filled"
		case settingsTabBarButton = "folder.badge.gearshape"
	}
}
