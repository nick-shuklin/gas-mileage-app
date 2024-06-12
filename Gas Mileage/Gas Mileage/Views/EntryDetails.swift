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
	
	var body: some View {
		VStack {
			HStack {
				Text("Odometer")
				Spacer()
				Text("\(item.odometer)")
			}
		}
	}
}
