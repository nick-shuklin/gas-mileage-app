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
		case listView = "list_view"
		
		case entryLinkPrefix = "navigation_link_"
		case entryLogoPrefix = "entry_row_logo_"
		case entryFillupDatePrefix = "entry_row_fillupdate_"
		case entryOdometerPrefix = "entry_row_odometer_"
		case entryGasPricePrefix = "entry_row_gasprice_"
		case entryTotalPrefix = "entry_row_total_"
		case entryGasMileagePrefix = "entry_row_gasmileage_"
		case entryVolumePrefix = "entry_row_volume_"
	}
	
	enum TabBar: String {
		case mainTabBarButton = "house"
		case entriesTabBarButton = "fuelpump"
		case chartsTabBarButton = "waveform.and.person.filled"
		case settingsTabBarButton = "folder.badge.gearshape"
	}
}
