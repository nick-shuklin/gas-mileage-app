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
    @Query private var items: [GasFillEntry]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
					NavigationLink(value: item) {
						EntryRow(item: item)
					}
                }
                .onDelete(perform: deleteItems)
            }
			.navigationTitle("List of entries")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
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
