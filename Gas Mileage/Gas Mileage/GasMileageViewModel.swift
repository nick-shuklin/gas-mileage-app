//
//  GasMileageViewModel.swift
//  Gas Mileage
//
//  Created by Nick Shuklin on 6/6/24.
//

import SwiftUI

class GasMileageViewModel:ObservableObject {
	private var model: GasMileageModel
	
	var entries: Array<GasMileageModel.Entry> {
		return model.entries
	}
	
	func add() -> Void {
		
	}
	
	func remove() -> Void {
		
	}
}
