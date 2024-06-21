//
//  MainView.swift
//  Gas Mileage
//
//  Created by Nick Shuklin on 6/21/24.
//

import SwiftUI
import SwiftData

struct MainView: View {
	static let amountOfEntriesToDisplay = 10
	static var fetchDescriptor: FetchDescriptor<GasFillEntry> {
		var descriptor = FetchDescriptor<GasFillEntry>(
			predicate: #Predicate { $0.isPaidCash == true },
			sortBy: [
				.init(\.timestamp)
			]
		)
		descriptor.fetchLimit = amountOfEntriesToDisplay
		return descriptor
	}

	@Query(MainView.fetchDescriptor) private var items: [GasFillEntry]
	@Environment(\.modelContext) private var modelContext
	
    var body: some View {
		HStack {
			Spacer()
			NavigationSplitView {
				List(items) { EntryRowView(item: $0) }
					.navigationTitle("Last \(MainView.amountOfEntriesToDisplay) of entries")
			} detail: {
				Text("Select an item")
			}
		}
    }
}

#Preview {
    MainView()
		.modelContainer(for: GasFillEntry.self, inMemory: false)
}
