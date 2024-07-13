//
//  ChartsView.swift
//  Gas Mileage
//
//  Created by Nick Shuklin on 6/14/24.
//

import SwiftUI
import Charts
import SwiftData

struct ChartsView: View {
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
			}
		}
		.padding()
    }
}