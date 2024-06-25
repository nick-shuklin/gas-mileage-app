//
//  ContentView.swift
//  Gas Mileage
//
//  Created by Nick Shuklin on 6/3/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
	@Environment(\.modelContext) private var modelContext
	@Query(sort: \GasFillEntry.odometer, order: .reverse) private var items: [GasFillEntry]
	@State private var showEditEntryView: Bool = false
	@State private var showTabBar = true

    var body: some View {
		TabView {
			MainView()
				.tabItem {
					Label("Main",
						  systemImage: "house.circle.fill")
				}
			NavigationSplitView {
				List {
					ForEach(items) { item in
						NavigationLink(value: item) {
							EntryRowView(item: item)
						}
						.toolbar(showTabBar ? .visible : .hidden, for: .tabBar)
						.listRowBackground(item.isFilledUp ? Color.green : Color.blue)
					}
					.onDelete(perform: deleteItems)
				}
				.navigationTitle("List of entries")
				.navigationDestination(for: GasFillEntry.self) { item in
					EntryDetailsView(item: item, showTabBar: $showTabBar)
				}
				.toolbar {
					ToolbarItem(placement: .topBarLeading) {
						Button {
							showEditEntryView.toggle()
						} label: {
							Label("Add Item", systemImage: "plus")
						}
						.sheet(isPresented: $showEditEntryView) {
							let newItem = GasFillEntry(timestamp: Date(),
													   timeOfFillUp: Date())
							EditEntryView(item: newItem)
						}
					}
					ToolbarItem(placement: .navigationBarTrailing) {
						EditButton()
					}
					ToolbarItem {
						Button(action: addItem) {
							Label("Add Item", systemImage: "allergens")
						}
					}
				}
			} detail: {
				Text("Select an item")
			}
			.tabItem {
				Label("Entries",
					  systemImage: "fuelpump.circle")
			}
			
			GraphsView()
				.tabItem {
					Label("Graphs",
						  systemImage: "waveform.circle")
				}
			
			SettingsView()
				.tabItem {
					Label("Settings", systemImage: "gear")
				}
		}
    }

    private func addItem() {
        withAnimation {
            let newItem = GasFillEntry(timestamp: Date(),
									   timeOfFillUp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: GasFillEntry.self, inMemory: false)
}
