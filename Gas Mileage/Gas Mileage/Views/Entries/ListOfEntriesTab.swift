import SwiftUI
import SwiftData

struct ListOfEntriesTab: View {
	@Environment(\.modelContext) private var modelContext
	@Query(fetchDescriptorAll) private var items: [GasFillEntry]
	@State private var showEditEntryView: Bool = false
	@State private var showTabBar: Bool = true
	
	let frameHeight: CGFloat = 48
	
	var body: some View {
		NavigationStack {
			List {
				ForEach(items) { item in
					NavigationLink(destination: EntryDetailsView(item: item, showTabBar: $showTabBar)) {
						EntryRowView(item: item)
							.contentShape(Rectangle())
							.frame(height: frameHeight)
							.toolbar(showTabBar ? .visible : .hidden, for: .tabBar)
					}
					.accessibilityIdentifier("navigation_link_\(item.odometer)")
				}
				.onDelete(perform: deleteItems)
			}
			.accessibilityIdentifier("list_view")
			.navigationTitle("List of entries")
			.toolbarTitleDisplayMode(.inline)
			.toolbar {
				ToolbarItem(placement: .topBarLeading) {
					addEntryButton
						.sheet(isPresented: $showEditEntryView) {
							EditEntryView(entry: nil)
								.accessibilityIdentifier("navigation_bar_edit_entry")
						}
				}
				
				ToolbarItem(placement: .topBarTrailing) {
					EditButton()
						.accessibilityIdentifier("edit_button")
				}
				
#if DEBUG
				ToolbarItem {
					Button(action: addItem) {
						Label("Add Item", systemImage: "allergens")
					}
					.accessibilityIdentifier("generate_entry_button")
				}
#endif
			}
		}
	}
		
	private var addEntryButton: some View {
		Button {
			showEditEntryView.toggle()
		} label: {
			Image(systemName: "plus")
		}
		.accessibilityIdentifier("add_entry_button")
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
