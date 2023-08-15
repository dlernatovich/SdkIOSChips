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
    private var tint: Color { ChipsConfiguration.tint }
    /// {@link Color} value of the more button tint.
    private var moreButtonTint: Color { ChipsConfiguration.moreButtonTint }
    /// {@link CGFloat} of the corner radius.
    private var corner: CGFloat { ChipsConfiguration.corner }
    /// {@link Int} value of the more count.
    private var moreCount: Int { ChipsConfiguration.moreCount }
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
                    .foregroundColor(ChipsConfiguration.moreButtonTint)
                if moreCount > 0 {
                    ZStack {
                        RoundedRectangle(cornerRadius: ChipsConfiguration.corner)
                            .fill(ChipsConfiguration.tint)
                        Text(verbatim: "+\(moreCount)")
                            .font(.system(.caption2))
                            .fontWeight(.bold)
                            .foregroundColor(ChipsConfiguration.moreButtonBadgeTextTint)
                            .padding(.all, 3)
                    }
                }
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
            ).stroke(
                getStrokeColor(chip), lineWidth: SdkConstants.chipLineWidth
            )
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
            return moreButtonTint.opacity(SdkConstants.chipBackgroundOpacity)
        } else {
            if isRemovable {
                return .clear
            } else if chip.isSelected == true {
                return tint.opacity(SdkConstants.chipBackgroundOpacity)
            }
            return .clear
        }
    }
    
    /// Method which provide to get stroke color.
    /// - Parameter chip: instance.
    /// - Returns: color value.
    private func getStrokeColor(_ chip: Chip) -> Color {
        if chip.isMoreChip() == true {
            return moreButtonTint
        } else {
            return tint
        }
    }
}
