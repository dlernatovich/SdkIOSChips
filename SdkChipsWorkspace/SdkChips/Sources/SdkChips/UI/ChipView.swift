import Foundation
import SwiftUI

//MARK: - ChipView
/// View which provide the chip displaying.
internal struct ChipView : View {
    /// Instance of the chip.
    let chip: Chip
    /// {@link Bool} value if it is removable.
    let isRemovable: Bool
    /// {@link Color} value of the tint.
    let tint: Color
    /// {@link CGFloat} of the corner radius.
    let corner: CGFloat
    /// Click callback.
    let click: ChipClickCallback
    /// More click callback.
    let moreClick: MoreClickCallback?
    
    /// Instance of the view.
    var body: some View {
        HStack {
            if chip.isMoreChip() == true {
                Image(systemName: "ellipsis")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: SdkConstants.chipIconSize, height: SdkConstants.chipIconSize)
                    .foregroundColor(tint)
            } else {
                chip.image?
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: SdkConstants.chipIconSize, height: SdkConstants.chipIconSize)
                    .foregroundColor(tint)
                Text(chip.title)
                    .font(.body)
                    .foregroundColor(tint)
                if isRemovable == true {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: SdkConstants.chipCloseSize, height: SdkConstants.chipCloseSize)
                        .foregroundColor(tint)
                }
            }
        }
        .padding([.top, .bottom], SdkConstants.chipPaddingVertical)
        .padding([.leading, .trailing], SdkConstants.chipPaddingHorizontal)
        .foregroundColor(getForegroundColor(chip))
        .background(getBackgroundColor(chip))
        .cornerRadius(corner)
        .overlay(
            RoundedRectangle(
                cornerRadius: corner
            ).stroke(tint, lineWidth: SdkConstants.chipLineWidth)
        )
        .onTapGesture {
            if chip.isMoreChip() == true {
                moreClick?()
            } else {
                click(chip)
            }
        }
    }
    
    /// Method which provide to get foreground color.
    /// - Parameter chip: instance.
    /// - Returns: color value.
    private func getForegroundColor(_ chip: Chip) -> Color {
        if chip.isMoreChip() == true {
            return .clear
        } else {
            if chip.isSelected == true {
                return .clear
            }
            return tint.opacity(SdkConstants.chipBackgroundOpacity)
        }
    }
    
    /// Method which provide to get foreground color.
    /// - Parameter chip: instance.
    /// - Returns: color value.
    private func getBackgroundColor(_ chip: Chip) -> Color {
        if chip.isMoreChip() == true {
            return tint.opacity(SdkConstants.chipBackgroundOpacity)
        } else {
            if chip.isSelected == true {
                return tint.opacity(SdkConstants.chipBackgroundOpacity)
            }
            return .clear
        }
    }
}
