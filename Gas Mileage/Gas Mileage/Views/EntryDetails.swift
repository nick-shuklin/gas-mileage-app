//
//  EntryDetails.swift
//  Gas Mileage
//
//  Created by Nick Shuklin on 6/11/24.
//

import SwiftUI
import SwiftData

struct EntryDetails: View {
	@Bindable var item: GasFillEntry
	@State private var showEditEntryView: Bool = false
	
	var body: some View {
		VStack {
			HStack {
				Text("Odometer")
				Spacer()
				Text("\(item.odometer)")
			}.padding(20)
		}
		HStack {
			Button {
				showEditEntryView.toggle()
			} label: {
				Label("Edit", systemImage: "plus")
			}
			.sheet(isPresented: $showEditEntryView) {
				EditEntryView(item: item)
			}
		}
	}
}
