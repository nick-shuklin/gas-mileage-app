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
	
	enum EntryDetailsView: String {
		case fillupDateText = "fill_up_date"
		case gasStationNameText = "gas_station_name"
		case odometer = "odometer"
		case total = "total"
		case price = "price"
		case volume = "volume"
		case gasMileage = "gas_mileage"
		case tankFilledToggle = "tank_filled_toggle"
	}
	
	enum EditEntryOverlay: String {
		case editEntryMainView = "navigation_bar_edit_entry"
		case cancelButton = "cancel_button"
		case title = "title"
		case saveButton = "save_button"
		case fillUpDatePicker = "fill_up_date_picker"
		case gasStationPicker = "gas_station_picker"
		case odometerText = "odometer_text"
		case odometerTextfield = "odometer_textfield"
		case totalText = "total_text"
		case totalTextfield = "total_textfield"
		case priceText = "price_text"
		case priceTextfield = "price_textfield"
		case volumeText = "volume_text"
		case volumeTextfield = "volume_textfield"
		case tankFilledToggle = "tank_filled_toggle"
		case okAlertButton = "data_is_not_correct_alert_ok_button"
		case cancelAlertButton = "data_is_not_correct_alert_cancel_button"
		case alertMessage = "data_is_not_correct_alert_message"
	}
	
	enum TabBar: String {
		case mainTabBarButton = "house"
		case entriesTabBarButton = "fuelpump"
		case chartsTabBarButton = "waveform.and.person.filled"
		case settingsTabBarButton = "folder.badge.gearshape"
	}
}
