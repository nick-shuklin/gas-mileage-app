import SwiftUI
import SwiftData

struct ListOfEntriesTab: View {
	@Environment(\.modelContext) private var modelContext
	@Query(fetchDescriptorAll) private var items: [GasFillEntry]
	@State private var showEditEntryView: Bool = false
	@State private var showTabBar: Bool = true
	
	let frameHeight: CGFloat = 48
	
    var body: some View {
		VStack {
			NavigationSplitView {
				List {
					ForEach(items) { item in
						ZStack {
							NavigationLink(destination: EntryDetailsView(item: item, showTabBar: $showTabBar)) {
								EmptyView()
							}
							.opacity(0) // Hides the default NavigationLink's visibility

							EntryRowView(item: item)
								.contentShape(Rectangle())
								.frame(height: frameHeight)
//									.toolbar(showTabBar ? .visible : .hidden, for: .tabBar)
						}
					}
					.onDelete(perform: deleteItems)
				}
				.navigationTitle("List of entries")
				.toolbarTitleDisplayMode(.inline)
				.toolbar {
					ToolbarItem(placement: .topBarLeading) {
						addEntryButton
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
		}
    }
	
	private var addEntryButton: some View {
		Button {
			showEditEntryView.toggle()
		} label: {
			Image(systemName: "plus")
				.background(
					backGroundSquareShapedShadow()
						.frame(width: 30, height: 30)
				)
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
