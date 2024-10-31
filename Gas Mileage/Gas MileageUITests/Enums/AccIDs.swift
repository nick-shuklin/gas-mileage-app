/// Accessibility Identifiers used throughout the application for UI testing.
enum AccIDs {
	
	/// Accessibility Identifiers for the main screen elements.
	enum MainScreen: String {
		/// The main tab view.
		case mainTabView = "main_tab"
		
		/// The Year-to-Date (YTD) chart view.
		case chartView = "ytd_chart_view"
		
		/// The main scroll view.
		case scrollView = "scroll_view"
		
		/// The label displaying the last 10 entries.
		case last10EntriesLabel = "last_10_entries_label"
	}
	
	/// Accessibility Identifiers for the entries screen elements.
	enum EntriesScreen: String {
		/// The tab view for entries.
		case entriesTabView = "entries_tab"
		
		/// Button to add a new entry.
		case addEntryButton = "add_entry_button"
		
		/// Button to generate a new entry.
		case generateEntryButton = "generate_entry_button"
		
		/// Button to edit an existing entry.
		case editEntryButton = "edit_button"
		
		/// Icon for removing an image.
		case removeImage = "minus.circle.fill"
		
		/// The list view displaying all entries.
		case listView = "list_view"
		
		/// Prefix for the entry link navigation identifier.
		case entryLinkPrefix = "navigation_link_"
		
		/// Prefix for the entry row logo identifier.
		case entryLogoPrefix = "entry_row_logo_"
		
		/// Prefix for the entry row fill-up date identifier.
		case entryFillupDatePrefix = "entry_row_fillupdate_"
		
		/// Prefix for the entry row odometer identifier.
		case entryOdometerPrefix = "entry_row_odometer_"
		
		/// Prefix for the entry row gas price identifier.
		case entryGasPricePrefix = "entry_row_gasprice_"
		
		/// Prefix for the entry row total identifier.
		case entryTotalPrefix = "entry_row_total_"
		
		/// Prefix for the entry row gas mileage identifier.
		case entryGasMileagePrefix = "entry_row_gasmileage_"
		
		/// Prefix for the entry row volume identifier.
		case entryVolumePrefix = "entry_row_volume_"
	}
	
	/// Accessibility Identifiers for the entry details view elements.
	enum EntryDetailsView: String {
		/// Text field displaying the fill-up date.
		case fillupDateText = "fill_up_date"
		
		/// Text field for the gas station name.
		case gasStationNameText = "gas_station_name"
		
		/// Text field for the odometer reading.
		case odometer = "odometer"
		
		/// Text field for the total cost.
		case total = "total"
		
		/// Text field for the gas price.
		case price = "price"
		
		/// Text field for the volume.
		case volume = "volume"
		
		/// Text field for the calculated gas mileage.
		case gasMileage = "gas_mileage"
		
		/// Toggle switch for indicating a full tank.
		case tankFilledToggle = "tank_filled_toggle"
	}
	
	/// Accessibility Identifiers for the edit entry overlay elements.
	enum EditEntryOverlay: String {
		/// Main view for the edit entry navigation bar.
		case editEntryMainView = "navigation_bar_edit_entry"
		
		/// Button to cancel editing.
		case cancelButton = "cancel_button"
		
		/// The title text of the edit entry overlay.
		case title = "title"
		
		/// Button to save changes.
		case saveButton = "save_button"
		
		/// Date picker for selecting the fill-up date.
		case fillUpDatePicker = "fill_up_date_picker"
		
		/// Picker for selecting a gas station.
		case gasStationPicker = "gas_station_picker"
		
		/// Text label for the odometer.
		case odometerText = "odometer_text"
		
		/// Text field for entering the odometer reading.
		case odometerTextfield = "odometer_textfield"
		
		/// Text label for the total cost.
		case totalText = "total_text"
		
		/// Text field for entering the total cost.
		case totalTextfield = "total_textfield"
		
		/// Text label for the price per unit.
		case priceText = "price_text"
		
		/// Text field for entering the gas price.
		case priceTextfield = "price_textfield"
		
		/// Text label for the volume.
		case volumeText = "volume_text"
		
		/// Text field for entering the volume.
		case volumeTextfield = "volume_textfield"
		
		/// Toggle switch to indicate a full tank.
		case tankFilledToggle = "tank_filled_toggle"
		
		/// OK button in the alert dialog.
		case okAlertButton = "data_is_not_correct_alert_ok_button"
		
		/// Cancel button in the alert dialog.
		case cancelAlertButton = "data_is_not_correct_alert_cancel_button"
		
		/// Message text in the alert dialog.
		case alertMessage = "data_is_not_correct_alert_message"
	}
	
	/// Accessibility Identifiers for the tab bar elements.
	enum TabBar: String {
		/// Button to navigate to the main tab.
		case mainTabBarButton = "house"
		
		/// Button to navigate to the entries tab.
		case entriesTabBarButton = "fuelpump"
		
		/// Button to navigate to the charts tab.
		case chartsTabBarButton = "waveform.and.person.filled"
		
		/// Button to navigate to the settings tab.
		case settingsTabBarButton = "folder.badge.gearshape"
	}
}
