import Foundation
import SwiftUI

//MARK: - ChipsSelectionInternalView
/// Chips selection view.
internal struct ChipsSelectionInternalView : View {
    /// {@link Binding} value of the {@link PresentationMode}.
    @Environment(\.presentationMode) fileprivate var presentationMode: Binding<PresentationMode>
    /// Chip search.
    var chipSearch: Binding<String>
    /// Value of the title.
    let title: LocalizedStringKey
    /// Instance of the {@link ChipSection}.
    var sections: Binding<[ChipSection]>
    /// Limit value.
    let limit: Int?
    /// {@link Color} value of the tint.
    let tint: Color
    /// {@link CGFloat} of the corner radius.
    let corner: CGFloat
    
    /// Instance of the {@link View}.
    public var body: some View {
        let view = NavigationView {
            List {
                if chipSearch.wrappedValue.isEmpty == true {
                    ForEach(sections, id: \.id) {
                        SectionView(
                            section: $0,
                            isRemovable: false,
                            limit: limit,
                            tint: tint,
                            corner: corner,
                            moreClick: nil
                        )
                    }
                } else {
                    ChipsView(
                        chips: getChips(filter: chipSearch.wrappedValue),
                        isRemovable: false,
                        limit: limit,
                        tint: tint,
                        corner: corner,
                        click: { onClicked($0) },
                        moreClick: nil
                    )
                }
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button { presentationMode.wrappedValue.dismiss() } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
            .accentColor(tint)
        }
        // Add searchable.
        if #available(iOS 15.0, *) {
            view.searchable(text: chipSearch)
        } else {
            view
        }
    }
    
    /// Method which provide to get chips.
    /// - Parameter filter: value.
    /// - Returns: array of the chips.
    private func getChips(filter: String) -> [Chip] {
        sections.wrappedValue
            .flatMap { $0.chips }
            .filter { $0.title.stringKey?.lowercased().contains(filter.lowercased()) == true }
    }
    
    /// Method which provide the action clicked.
    /// - Parameter chip: instance.
    private func onClicked(_ chip: Chip) {
        for i in 0..<sections.wrappedValue.count {
            for j in 0..<sections.wrappedValue[i].chips.count {
                if sections.wrappedValue[i].chips[j].id == chip.id {
                    sections.wrappedValue[i].chips[j].isSelected.toggle()
                }
            }
        }
    }
}

//MARK: - ChipsSelectionView
/// Chip section view.
public struct ChipsSelectionView : View {
    /// {@link Bool} value if need to show.
    let isPresented: Binding<Bool>
    /// {@link String} value of the chip search.
    let chipSearch: Binding<String>
    /// Value of the title.
    let title: LocalizedStringKey
    /// Instance of the {@link ChipSection}.
    var sections: Binding<[ChipSection]>
    /// Limit value.
    let limit: Int?
    /// {@link Color} value of the tint.
    let tint: Color
    /// {@link CGFloat} of the corner radius.
    let corner: CGFloat
    
    /// Default constructor.
    /// - Parameters:
    ///   - isPresented: is presented.
    ///   - title: value.
    ///   - sections: sections array.
    ///   - limit: limit value.
    ///   - tint: tint color.
    ///   - corner: corner value.
    public init(
        isPresented: Binding<Bool>,
        chipSearch: Binding<String>,
        title: LocalizedStringKey,
        sections: Binding<[ChipSection]>,
        limit: Int?,
        tint: Color,
        corner: CGFloat
    ) {
        self.isPresented = isPresented
        self.chipSearch = chipSearch
        self.title = title
        self.sections = sections
        self.limit = limit
        self.tint = tint
        self.corner = corner
    }
    
    /// Instance of the {@link View}.
    public var body: some View {
        fullCover(isPresented: isPresented) {
            ChipsSelectionInternalView(
                chipSearch: chipSearch,
                title: title,
                sections: sections,
                limit: limit,
                tint: tint,
                corner: corner
            )
        }
    }
}
