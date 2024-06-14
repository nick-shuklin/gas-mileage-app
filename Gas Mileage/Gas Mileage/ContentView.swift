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

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
					NavigationLink(value: item) {
						EntryRow(item: item)
					}
					.listRowBackground(item.isFilledUp ? Color.green : Color.blue)
                }
                .onDelete(perform: deleteItems)
            }
			.navigationTitle("List of entries")
			.toolbar {
				ToolbarItem(placement: .topBarLeading) {
					Button {
						showEditEntryView.toggle()
					} label: {
						Label("Add Item", systemImage: "plus")
					}
					.sheet(isPresented: $showEditEntryView) {
						let newItem = GasFillEntry(timestamp: Date())
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
			.navigationDestination(for: GasFillEntry.self) { item in
				EntryDetails(item: item)
			}
        } detail: {
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = GasFillEntry(timestamp: Date())
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
        .modelContainer(for: GasFillEntry.self, inMemory: true)
}
