import Foundation
import SwiftUI

//MARK: - ChipView
/// View which provide the chip displaying.
internal struct ChipView : View {
    /// Instance of the {@link ChipViewContainer}.
    private var container: ChipViewContainer { .shared }
    /// Chip view type.
    private let type: ChipViewType
    
    /// Instance of the model.
    private let model: Any?
    /// Instance of the {@link Chip}.
    private var chip: Chip? { model as? Chip }
    /// Instance of the {@link Chip}.
    private var section: ChipSection? { model as? ChipSection }
    
    /// {@link String} value of the image name.
    private let imageName: String?
    /// Value of the more count.
    private let moreCount: Int
    /// Instance of the chip callback.
    private let click: ChipClickCallback?
    /// Instance of the more click callback.
    private let buttonClick: MoreClickCallback?
    
    /// {@link Color} value of the tint.
    private var tint: Color { ChipsConfiguration.tint }
    /// {@link Color} value of the tint opacity.
    private var tintOpacity: Color { tint.opacity(SdkConstants.chipBackgroundOpacity) }
    /// {@link CGFloat} of the corner radius.
    private var corner: CGFloat { ChipsConfiguration.corner }
    
    /// {@link Bool} value if it was expanded.
    @State private var isExpanded: Bool = false
    
    /// Method which provide the init functional.
    /// - Parameters:
    ///   - type: value.
    ///   - model: value.
    ///   - imageName: value.
    ///   - moreCount: value.
    ///   - click: callback.
    ///   - buttonClick: callback.
    init(
        type: ChipViewType,
        model: Chip,
        imageName: String?,
        moreCount: Int,
        click: ChipClickCallback?,
        buttonClick: MoreClickCallback?
    ) {
        self.type = type
        self.model = model
        self.imageName = imageName
        self.moreCount = moreCount
        self.click = click
        self.buttonClick = buttonClick
    }
    
    /// Method which provide the init functional.
    /// - Parameters:
    ///   - type: value.
    ///   - model: value.
    ///   - imageName: value.
    ///   - moreCount: value.
    ///   - click: callback.
    ///   - buttonClick: callback.
    init(
        type: ChipViewType,
        model: ChipSection,
        imageName: String?,
        moreCount: Int,
        click: ChipClickCallback?,
        buttonClick: MoreClickCallback?
    ) {
        self.type = type
        self.model = model
        self.imageName = imageName
        self.moreCount = moreCount
        self.click = click
        self.buttonClick = buttonClick
    }
    
    /// Instance of the view.
    var body: some View {
        switch type {
        case .more: getMoreButton()
        case .button: getButton(imageName)
        case .chip: getChip(chip!)
        case .chipRemovable: getChip(chip!)
        case .chipSection: getChipGroup(section!)
        case .chipSectionRemovable: getChipGroup(section!)
        }
    }
    
    /// Method which provide to get rectangle overlay.
    /// - Parameter it: color value.
    /// - Returns: overlay value.
    private func getOverlay(_ it: Color) -> some View {
        RoundedRectangle(cornerRadius: corner).stroke(it, lineWidth: SdkConstants.chipLineWidth)
    }
    
    /// Method which provide to get rectangle overlay.
    /// - Parameter it: color value.
    /// - Returns: overlay value.
    private func getFillOverlay(_ it: Color) -> some View {
        RoundedRectangle(cornerRadius: corner).fill(it)
    }
    
    /// Method which provide to get some view.
    /// - Returns: view instance.
    private func getMoreButton() -> some View { getButton("41eb014b-e807-43f1-adf9-2ce4a503f036") }
    
    /// Method which provide to get button view.
    /// - Returns: instance of the view.
    private func getButton(_ it: String?) -> some View {
        HStack {
            Image(it ?? imageName!, bundle: Bundle.module)
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: SdkConstants.chipIconSize, height: SdkConstants.chipIconSize)
                .foregroundColor(Color(UIColor.tertiarySystemBackground))
            if moreCount > 0 {
                Text(verbatim: "+\(moreCount)")
                    .font(.system(.caption2))
                    .fontWeight(.bold)
                    .foregroundColor(tint)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(getFillOverlay(Color(UIColor.tertiarySystemBackground)))
                    .fixedSize()
            }
        }
        .padding([.top, .bottom], SdkConstants.chipPaddingVertical)
        .padding([.leading, .trailing], SdkConstants.chipPaddingHorizontal)
        .foregroundColor(tint)
        .background(tint)
        .cornerRadius(corner)
        .overlay(getOverlay(tint))
        .onTapGesture { buttonClick?() }
    }
    
    /// Method which provide to get chip view.
    /// - Parameter it: model object.
    /// - Returns: instance of the view.
    private func getChip(_ it: Chip) -> some View {
        HStack {
            it.image?
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: SdkConstants.chipIconSize, height: SdkConstants.chipIconSize)
                .foregroundColor(tint)
            Text(it.title).font(.body).foregroundColor(tint)
            if type == .chipRemovable {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: SdkConstants.chipCloseSize, height: SdkConstants.chipCloseSize)
                    .foregroundColor(tint)
            }
        }
        .padding([.top, .bottom], SdkConstants.chipPaddingVertical)
        .padding([.leading, .trailing], SdkConstants.chipPaddingHorizontal)
        .foregroundColor((it.isSelected == true) ? tintOpacity : .clear)
        .background((it.isSelected == true) ? tintOpacity : .clear)
        .cornerRadius(corner)
        .overlay(getOverlay(tint))
        .onTapGesture { click?(it, nil) }
    }
    
    /// Method which provide to get button view.
    /// - Returns: instance of the view.
    private func getChipGroup(_ it: ChipSection) -> some View {
        HStack {
            Text(it.title)
                .font(.body)
                .foregroundColor(tint)
            HStack(spacing: 2) {
                if isExpanded {
                    ForEach(it.chips.filter { $0.isSelected }, id: \.self) { chip in
                        Text(chip.title)
                            .font(.system(.caption2))
                            .fontWeight(.bold)
                            .foregroundColor(Color(UIColor.tertiarySystemBackground))
                            .padding(.horizontal, 8)
                            .padding(.vertical, 3)
                            .background(getFillOverlay(tint))
                            .fixedSize()
                    }
                }
                if it.getSelectedCount() > 0 {
                    Text(verbatim: "+\(it.getSelectedCount())")
                        .font(.system(.caption2))
                        .fontWeight(.bold)
                        .foregroundColor(Color(UIColor.tertiarySystemBackground))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(getFillOverlay(tint))
                        .fixedSize()
                }
            }
            ((isExpanded == true) ? Image.imageArrowLeft : Image.imageArrowRight)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: SdkConstants.chipArrowSize, height: SdkConstants.chipArrowSize)
                .foregroundColor(tint)
            if type == .chipSectionRemovable {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: SdkConstants.chipCloseSize, height: SdkConstants.chipCloseSize)
                    .foregroundColor(tint)
                    .onTapGesture { click?(nil, it) }
            }
        }
        .onAppear(perform: { isExpanded = container.get(id: it.id) })
        .padding([.top, .bottom], SdkConstants.chipPaddingVertical)
        .padding([.leading, .trailing], SdkConstants.chipPaddingHorizontal)
        .foregroundColor(Color.clear)
        .background(Color.clear)
        .cornerRadius(ChipsConfiguration.corner)
        .overlay(getOverlay(tint))
        .onTapGesture {
            isExpanded.toggle()
            container.set(id: it.id, value: isExpanded)
        }
    }
    
}

/// Container for the {@link ChipView}.
private class ChipViewContainer {
    
    /// Instance of the {@link ChipViewContainer}.
    static let shared: ChipViewContainer = .init()
    
    /// Instance of the {@link UserDefaults}.
    private let settings = UserDefaults(suiteName: "55522a4a-1f39-4065-a6ee-771e2ddb8777")
    
    /// Method which provide the set functional.
    /// - Parameters:
    ///   - id: section id value.
    ///   - value: value if it was expanded.
    func set(id: String, value: Bool, finish: (() -> Void) = {}) {
        settings?.setValue(value, forKey: id)
        finish()
    }
    
    /// Method which provide to get the expanded state for the section.
    /// - Parameter id: section id value.
    /// - Returns: if it expanded.
    func get(id: String?) -> Bool {
        guard let id = id else { return true }
        let value = settings?.bool(forKey: id) ?? true
        return value
    }
    
}
