import SwiftUI
import SwiftData

struct ListOfEntriesTab: View {
	@Environment(\.modelContext) private var modelContext
	@Query(fetchDescriptorAll) private var items: [GasFillEntry]
	@State private var showEditEntryView: Bool = false
	@State private var showTabBar = true
	
	let frameHeight: CGFloat = 54
//	let radius: CGFloat = 7
//	let modifier: CGFloat = 8
//	
//	let innerColor1 = Color(hex: "FFFFFF").opacity(0.64)
//	let innerColor2 = Color(hex: "0D2750").opacity(0.16)
//	/// B5BFC6 FAFBFF E4EBF1 FFFFFF 6E7F8D 0D2750 161B1D EFF2F9
//	@State private var innerBlur1: CGFloat = 43
//	@State private var innerBlur2: CGFloat = 48
//	@State private var innerXY1: CGFloat = -31
//	@State private var innerXY2: CGFloat = 26
//	
//	let dropColor1 = Color(hex: "0D2750").opacity(0.16)
//	let dropColor2 = Color(hex: "FFFFFF")
//	@State private var dropBlur1: CGFloat = 50
//	@State private var dropBlur2: CGFloat = 45
//	@State private var dropXY1: CGFloat = 28
//	@State private var dropXY2: CGFloat = -23
	
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
//							.listRowSeparator(.hidden)
							.listRowBackground(Color.clear)
//							.background(
//								RoundedRectangle(cornerRadius: frameHeight/5)
//									.fill(
////										.shadow(.inner(color: innerColor1,
////													   radius: innerBlur1/modifier,
////													   x: innerXY1/modifier, 
////													   y: innerXY1/modifier))
////										.shadow(.inner(color: innerColor2,
////													   radius: innerBlur2/modifier,
////													   x: innerXY2/modifier, 
////													   y: innerXY2/modifier))
////										.shadow(.drop(color: dropColor1,
////													  radius: dropBlur1/modifier,
////													  x: dropXY1/modifier, 
////													  y: dropXY1/modifier))
////										.shadow(.drop(color: dropColor2,
////													  radius: dropBlur2/modifier,
////													  x: dropXY2/modifier, 
////													  y: dropXY2/modifier))
//									)
//									.foregroundColor(Color.background)
//							)
						}
						.onDelete(perform: deleteItems)
					}
					.navigationTitle("List of entries")
					.toolbarTitleDisplayMode(.inline)
					.navigationDestination(for: GasFillEntry.self) { item in
						EntryDetailsView(item: item, showTabBar: $showTabBar)
					}
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
