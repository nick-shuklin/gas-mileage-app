import SwiftUI

struct LogoView: View {
	let logoSize: CGFloat = 36
	let logoName: String
	
	var body: some View {
		ZStack {
			Color.white
				.frame(width: logoSize + 2,
					   height: logoSize + 2)
				.cornerRadius(5)
			
			Image(uiImage: UIImage(named: logoName) ?? UIImage(named: "Default")!)
				.renderingMode(.original)
				.resizable()
				.aspectRatio(contentMode: .fit)
				.frame(width: logoSize,
					   height: logoSize)
				.cornerRadius(5)
				.clipped()
		}
	}
}
