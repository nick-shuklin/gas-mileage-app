//
//  ListOfEntriesView.swift
//  Gas Mileage
//
//  Created by Nick Shuklin on 6/30/24.
//

import SwiftUI
import SwiftData

struct ListOfEntriesView: View {
	@Environment(\.modelContext) private var modelContext
	@Query(sort: \GasFillEntry.odometer, order: .reverse) private var items: [GasFillEntry]
	@State private var showEditEntryView: Bool = false
	@State private var showTabBar = true
	
    var body: some View {
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
						EditEntryView(entry: nil)
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
    }
	
	private func addItem() {
		withAnimation {
			let newItem = GasFillEntry()
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
