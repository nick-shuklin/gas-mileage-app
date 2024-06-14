//
//  AppVersionProvider.swift
//  Gas Mileage
//
//  Created by Nick Shuklin on 6/14/24.
//

import Foundation

enum AppVersionProvider {
	static func appVersion(in bundle: Bundle = .main) -> String {
		guard let version = bundle.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String else {
			fatalError("CFBundleShortVersionString should not be missing from info dictionary")
		}
		return version
	}
}
