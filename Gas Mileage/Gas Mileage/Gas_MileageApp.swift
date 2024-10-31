import SwiftUI
import SwiftData

@main
struct Gas_MileageApp: App {
	// Lazily initialize the shared model container to improve app launch performance
	private lazy var sharedModelContainer: ModelContainer = Gas_MileageApp.createModelContainer()

	var body: some Scene {
		WindowGroup {
			ContentView()
		}
		.modelContainer(for: GasFillEntry.self) { result in
			switch result {
			case .success(let container):
				preseedDatabaseIfNeeded(using: container)
			case .failure(let error):
				print("❌ Failed to load model container: \(error)")
			}
		}
	}
}

// MARK: - Private Methods

private extension Gas_MileageApp {
	/// Creates and configures the model container for the app.
	/// - Returns: A configured `ModelContainer` for use in the app.
	static func createModelContainer() -> ModelContainer {
		let schema = Schema([GasFillEntry.self])
		let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

		do {
			return try ModelContainer(for: schema, configurations: [modelConfiguration])
		} catch {
			fatalError("Could not create ModelContainer: \(error)")
		}
	}

	/// Pre-seeds the database with testing data if needed (only for DEBUG builds).
	/// - Parameter container: The `ModelContainer` instance used to interact with the database.
	func preseedDatabaseIfNeeded(using container: ModelContainer) {
		#if DEBUG
		do {
			let descriptor = FetchDescriptor<GasFillEntry>()
			let existingEntriesCount = try container.mainContext.fetchCount(descriptor)
			guard existingEntriesCount == 0 else { return } // Skip if there are already entries

			guard let url = Bundle.main.url(forResource: "testing_data", withExtension: "json") else {
				print("Failed to find testing_data.json")
				return
			}

			let data = try Data(contentsOf: url)
			let decoder = JSONDecoder()
			decoder.dateDecodingStrategy = .iso8601

			let items = try decoder.decode([GasFillEntry].self, from: data)
			for item in items {
				container.mainContext.insert(item)
			}
			print("Successfully pre-seeded the database.")
		} catch {
			print("Failed to pre-seed database: \(error)")
		}
		#endif
	}
}
