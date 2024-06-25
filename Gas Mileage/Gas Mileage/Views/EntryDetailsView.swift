//
//  EntryDetailsView.swift
//  Gas Mileage
//
//  Created by Nick Shuklin on 6/11/24.
//

import SwiftUI
import SwiftData

struct EntryDetailsView: View {
	@Bindable var item: GasFillEntry
	@State private var showEditEntryView: Bool = false
	@Binding var showTabBar: Bool
	
	var body: some View {
		Form {
			Section {
				Text(item.timeOfFillUp, format: Date.FormatStyle(date: .abbreviated, time: .shortened))
				Text(item.gasStationName.rawValue)
			}
			Section {
				VStack {
					HStack {
						Text("Odometer")
						Spacer()
						Text("\(item.odometer) miles")
					}
					HStack {
						Text("Total")
						Spacer()
						Text("$ " + String(item.total.roundTo(places: 2)))
					}
					HStack {
						Text("Price")
						Spacer()
						Text("$ " + String(item.gasPrice.roundTo(places: 2)) + " per gal")
					}
					HStack {
						Text("Volume")
						Spacer()
						Text(String(item.volume.roundTo(places: 2)) + " gal")
					}
					// FIXME: when formatting is fixed uncomment out this part
//					if item.gasMileage != nil {
						HStack {
							Text("Gas mileage")
							Spacer()
							Text(String(item.gasMileage?.roundTo(places: 2) ?? 0) + " mpg")
						}
//					}
				}
			}
			Section {
				Toggle(String("Tank filled up?"), isOn: $item.isFilledUp)
				Toggle(String("Paid cash?"), isOn: $item.isPaidCash)
			}
		}
		.onAppear {
			withAnimation {
				showTabBar.toggle()
			}
		}
		.onDisappear {
			withAnimation {
				showTabBar.toggle()
			}
		}
		
		HStack {
			Button {
				showEditEntryView.toggle()
			} label: {
				Label("Edit", systemImage: "edit")
			}
			.sheet(isPresented: $showEditEntryView) {
				EditEntryView(item: item)
			}
		}
	}
}
