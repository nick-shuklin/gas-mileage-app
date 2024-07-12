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
		NavigationStack {
			Form {
				Section {
					Text(item.timeOfFillUp, format: Date.FormatStyle(date: .abbreviated, time: .shortened))
					Text(item.gasStationName.rawValue)
				}
				
				Section {
					VStack {
						HStack {
							Text("Odometer")
							HStack(alignment: .lastTextBaseline) {
								Spacer()
								Text("\(item.odometer) miles")
								Spacer()
							}
						}
						
						HStack {
							Text("Total")
							HStack(alignment: .lastTextBaseline) {
								Spacer()
								Text("$" + String(item.total.roundTo(places: 2)))
								Spacer()
							}
						}
						
						HStack {
							Text("Price")
							HStack(alignment: .lastTextBaseline) {
								Spacer()
								Text("$" + String(item.gasPrice.roundTo(places: 2)) + " per gal")
								Spacer()
							}
						}
						
						HStack {
							Text("Volume")
							HStack(alignment: .lastTextBaseline) {
								Spacer()
								Text(String(item.volume.roundTo(places: 2)) + " gal")
								Spacer()
							}
						}
						
						HStack {
							Text("Gas mileage")
							HStack(alignment: .lastTextBaseline) {
								Spacer()
								Text(String(item.gasMileage.roundTo(places: 2)) + " mpg")
								Spacer()
							}
						}
					}
				}
				
				Section {
					Toggle(String("Tank filled up?"), isOn: $item.isFilledUp)
					Toggle(String("Paid cash?"), isOn: $item.isPaidCash)
				}
			}
			.toolbar {
				ToolbarItem(placement: .principal) {
					Text("Entry details")
				}
				
				ToolbarItem(placement: .automatic) {
					Button {
						showEditEntryView.toggle()
					} label: {
						Label("Edit", systemImage: "edit")
					}
					.sheet(isPresented: $showEditEntryView) {
						EditEntryView(entry: item)
					}
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
		}
	}
}
