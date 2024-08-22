import SwiftUI
import SwiftData

@main
struct Gas_MileageApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            GasFillEntry.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
		#if DEBUG
			WindowGroup {
				ContentView()
			}
			.modelContainer(for: GasFillEntry.self) { result in
				do {
					let container = try result.get()

					let descriptor = FetchDescriptor<GasFillEntry>()
					let existingUsers = try container.mainContext.fetchCount(descriptor)
					guard existingUsers == 0 else { return }

					guard let url = Bundle.main.url(forResource: "testing_data", withExtension: "json") else {
						fatalError("Failed to find testing_data.json")
					}

					let data = try Data(contentsOf: url)
					let decoder = JSONDecoder()
					decoder.dateDecodingStrategy = .iso8601
					
					let items = try decoder.decode([GasFillEntry].self, from: data)

					for item in items {
						container.mainContext.insert(item)
					}
				} catch {
					print("Failed to pre-seed database.")
				}
			}
		#else
			WindowGroup {
				ContentView()
			}
			.modelContainer(sharedModelContainer)
		#endif
    }
}
