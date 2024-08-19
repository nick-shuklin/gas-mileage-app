import SwiftUI
import SwiftData

struct ListOfEntriesTab: View {
	@Environment(\.modelContext) private var modelContext
	@Query(fetchDescriptorAll) private var items: [GasFillEntry]
	@State private var showEditEntryView: Bool = false
	@State private var showTabBar = true
	
	let frameHeight: CGFloat = 54
	
    var body: some View {
		ZStack {
			Color.background
				.ignoresSafeArea()
			
			VStack {
				NavigationSplitView {
					List {
						ForEach(items) { item in
							NavigationLink(value: item) {
								EntryRowView(item: item)
							}
							.frame(height: frameHeight)
							.toolbar(showTabBar ? .visible : .hidden, for: .tabBar)
						}
						.onDelete(perform: deleteItems)
					}
					.navigationDestination(for: GasFillEntry.self) { item in
						EntryDetailsView(item: item, showTabBar: $showTabBar)
					}
					.navigationTitle("List of entries")
					.toolbarTitleDisplayMode(.inline)
					.toolbar {
						ToolbarItem(placement: .topBarLeading) {
							Button {
								showEditEntryView.toggle()
							} label: {
								Label("Add Item", systemImage: "plus")
							}
							.sheet(isPresented: $showEditEntryView) {
								EditEntryView(entry: nil)
							}
						}
						
						ToolbarItem(placement: .navigationBarTrailing) {
							EditButton()
						}
						
#if DEBUG
						ToolbarItem {
							Button(action: addItem) {
								Label("Add Item", systemImage: "allergens")
							}
						}
#endif
					}
				} detail: {
					Text("Select an item")
				}
				.background(Color.background)
			}
		}
    }
	
	private func addItem() {
		withAnimation {
			let newItem = GasFillEntry()
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
