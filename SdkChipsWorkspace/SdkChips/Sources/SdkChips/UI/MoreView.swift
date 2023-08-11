import Foundation
import SwiftUI

/// More view icon.
struct MoreView : View {
    /// {@link Color} value of the tint.
    let tint: Color
    /// {@link CGFloat} of the corner radius.
    let corner: CGFloat
    /// More click.
    let click: () -> Void
    
    /// Instance of the body {@link View}.
    var body: some View {
        HStack {
            Image(systemName: "")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: SdkConstants.chipIconSize, height: SdkConstants.chipIconSize)
                .foregroundColor(tint)
        }
        .padding([.top, .bottom], SdkConstants.chipPaddingVertical)
        .padding([.leading, .trailing], SdkConstants.chipPaddingHorizontal)
        .foregroundColor(.clear)
        .background(tint.opacity(SdkConstants.chipBackgroundOpacity))
        .cornerRadius(corner)
        .overlay(
            RoundedRectangle(
                cornerRadius: corner
            ).stroke(tint, lineWidth: SdkConstants.chipLineWidth)
        )
        .onTapGesture { click() }
    }
}
