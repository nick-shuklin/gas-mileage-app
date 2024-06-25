//
//  GraphsView.swift
//  Gas Mileage
//
//  Created by Nick Shuklin on 6/14/24.
//

import SwiftUI
import Charts
import SwiftData

struct GraphsView: View {
	@Query(sort: \GasFillEntry.odometer, order: .reverse) private var items: [GasFillEntry]
	
    var body: some View {
		VStack {
			Section {
				Chart {
					ForEach(items) { item in
						BarMark(
							x: .value("Date", item.timeOfFillUp),
							y: .value("Odometer", item.odometer)
						)
					}
				}
				.padding(20)
			}
			Section {
				Chart {
					ForEach(items) { item in
						BarMark(
							x: .value("Date", item.timeOfFillUp),
							y: .value("Volume", item.volume)
						)
					}
				}
				.padding(20)
			}
		}
    }
}
