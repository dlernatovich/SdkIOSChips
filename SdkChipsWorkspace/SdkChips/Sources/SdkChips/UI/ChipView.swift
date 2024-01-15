import Foundation
import SwiftUI

//MARK: - ChipView
/// View which provide the chip displaying.
internal struct ChipView : View {
    /// Instance of the chip.
    let chip: Chip?
    /// Instance of the chip section.
    let section: ChipSection?
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
            if isMoreChip(chip, section) == true {
                Image("41eb014b-e807-43f1-adf9-2ce4a503f036", bundle: Bundle.module)
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: SdkConstants.chipIconSize, height: SdkConstants.chipIconSize)
                    .foregroundColor(Color(UIColor.tertiarySystemBackground))
                if moreCount > 0 {
                    ZStack {
                        RoundedRectangle(cornerRadius: ChipsConfiguration.corner)
                            .fill(Color(UIColor.tertiarySystemBackground))
                        Text(verbatim: "+\(moreCount)")
                            .font(.system(.caption2))
                            .fontWeight(.bold)
                            .foregroundColor(ChipsConfiguration.moreButtonTint)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 3)
                    }.fixedSize()
                }
            } else if let chip = chip {
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
            } else if let section = section {
                Text(section.title)
                    .font(.body)
                    .foregroundColor(tint)
                if section.selectedCount > 0 {
                    ZStack {
                        RoundedRectangle(cornerRadius: ChipsConfiguration.corner)
                            .fill(ChipsConfiguration.tint)
                        Text(verbatim: "+\(section.selectedCount)")
                            .font(.system(.caption2))
                            .fontWeight(.bold)
                            .foregroundColor(ChipsConfiguration.moreButtonBadgeTextTint)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 3)
                    }.fixedSize()
                }
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
        .foregroundColor(getForegroundColor(chip, section))
        .background(getBackgroundColor(chip, section))
        .cornerRadius(corner)
        .overlay(
            RoundedRectangle(
                cornerRadius: corner
            ).stroke(
                getStrokeColor(chip, section), lineWidth: SdkConstants.chipLineWidth
            )
        )
        .onTapGesture {
            if isMoreChip(chip, section) == true {
                moreClick?()
            } else {
                click(chip, section)
            }
        }
    }
    
    /// Check if current chip is more.
    /// - Parameters:
    ///   - chip: instance.
    ///   - section: instance.
    /// - Returns: if is mre chip.
    private func isMoreChip(_ chip: Chip?, _ section: ChipSection?) -> Bool {
        return chip?.isMoreChip() ?? section?.isMoreChip() ?? false
    }
    
    /// Method which provide to get foreground color.
    /// - Parameter chip: instance.
    /// - Returns: color value.
    private func getForegroundColor(_ chip: Chip?, _ section: ChipSection?) -> Color {
        if isMoreChip(chip, section) == true {
            return ChipsConfiguration.moreButtonTint
        } else if let it = chip {
            if it.isSelected == true {
                return .clear
            }
            return tint.opacity(SdkConstants.chipBackgroundOpacity)
        } else if let it = section {
            if it.hasSelected == true {
                return .clear
            }
            return tint.opacity(SdkConstants.chipBackgroundOpacity)
        }
        return .clear
    }
    
    /// Method which provide to get foreground color.
    /// - Parameter chip: instance.
    /// - Returns: color value.
    private func getBackgroundColor(_ chip: Chip?, _ section: ChipSection?) -> Color {
        if isMoreChip(chip, section) == true {
            return ChipsConfiguration.moreButtonTint
        } else if let it = chip {
            if isRemovable {
                return .clear
            } else if it.isSelected == true {
                return tint.opacity(SdkConstants.chipBackgroundOpacity)
            }
            return .clear
        } else if let it = section {
            if isRemovable {
                return .clear
            } else if it.hasSelected == true {
                return tint.opacity(SdkConstants.chipBackgroundOpacity)
            }
            return .clear
        }
        return .clear
    }
    
    /// Method which provide to get stroke color.
    /// - Parameter chip: instance.
    /// - Returns: color value.
    private func getStrokeColor(_ chip: Chip?, _ section: ChipSection?) -> Color {
        if isMoreChip(chip, section) == true {
            return moreButtonTint
        } else {
            return tint
        }
    }
}
