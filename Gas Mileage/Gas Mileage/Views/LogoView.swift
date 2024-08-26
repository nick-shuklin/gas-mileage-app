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
			
			if let uiImage = UIImage(named: logoName) {
				Image(uiImage: uiImage)
					.renderingMode(.original)
					.resizable()
					.saturation(0)
					.contrast(0.7)
					.aspectRatio(contentMode: .fit)
					.frame(width: logoSize,
						   height: logoSize)
					.cornerRadius(5)
					.clipped()
			} else {
				Image(uiImage: UIImage(named: "Default")!)
					.renderingMode(.original)
					.resizable()
					.saturation(0)
					.contrast(0.7)
					.aspectRatio(contentMode: .fit)
					.frame(width: logoSize,
						   height: logoSize)
					.cornerRadius(5)
					.clipped()
			}
		}
	}
}
