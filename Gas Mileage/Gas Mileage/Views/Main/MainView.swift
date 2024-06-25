//
//  MainView.swift
//  Gas Mileage
//
//  Created by Nick Shuklin on 6/21/24.
//

import SwiftUI
import SwiftData
import Charts

struct MainView: View {
	static let amountOfEntriesToDisplay = 10
	static var fetchDescriptor: FetchDescriptor<GasFillEntry> {
		var descriptor = FetchDescriptor<GasFillEntry>(
			predicate: #Predicate { $0.isPaidCash == true },
			sortBy: [SortDescriptor(\.odometer, order: .reverse)]
		)
		descriptor.fetchLimit = amountOfEntriesToDisplay
		return descriptor
	}

	@Query(MainView.fetchDescriptor) private var items: [GasFillEntry]
	@Environment(\.modelContext) private var modelContext
	
    var body: some View {
		VStack {
			Text("Main screen")
			Chart {
				ForEach(items) { item in
					BarMark(
						x: .value("Odometer", item.odometer),
						y: .value("Total", item.total)
					)
				}
			}
			.chartScrollableAxes(.horizontal)
			.chartScrollTargetBehavior(.valueAligned(unit: 2))
			.padding()
			Divider()
			NavigationSplitView {
				List(items) { ShortEntryRowView(item: $0) }
					.navigationTitle("Last \(MainView.amountOfEntriesToDisplay) of entries")
					.toolbarTitleDisplayMode(.inline)
			} detail: {
				Text("Select an item")
			}
		}
    }
}