import SwiftUI
import SwiftData

struct ListOfEntriesTab: View {
	@Environment(\.modelContext) private var modelContext
	@Query(fetchDescriptorAll) private var items: [GasFillEntry]
	@State private var showEditEntryView: Bool = false
	@State private var showTabBar: Bool = true
	@State private var selectedItem: GasFillEntry? = nil

	let frameHeight: CGFloat = 48

	var body: some View {
		ZStack {
			Color.background
				.ignoresSafeArea()

			VStack {
				NavigationSplitView {
					List(selection: $selectedItem) {
						ForEach(items) { item in
							ZStack {
								NavigationLink(value: item) {
									EntryRowView(item: item)
										.contentShape(Rectangle())
										.frame(height: frameHeight)
//										.toolbar(showTabBar ? .visible : .hidden, for: .tabBar)
								}
							}
						}
						.onDelete(perform: deleteItems)
					}
					.navigationTitle("List of entries")
					.toolbarTitleDisplayMode(.inline)
					.toolbar(showTabBar ? .visible : .hidden, for: .tabBar)
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
					if let selectedItem = selectedItem {
						EntryDetailsView(item: selectedItem, showTabBar: $showTabBar)
					} else {
						Text("Select an item")
					}
				}
				.navigationDestination(for: GasFillEntry.self) { item in
					EntryDetailsView(item: item, showTabBar: $showTabBar)
				}
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
				let itemToDelete = items[index]
				if selectedItem == itemToDelete {
					selectedItem = nil // Deselect the item if it’s being deleted
				}
				modelContext.delete(itemToDelete)
			}
		}
	}
}
