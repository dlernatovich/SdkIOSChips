import Foundation
import SwiftUI

//MARK: - ChipsSelectionInternalView
/// Chips selection view.
internal struct ChipsSelectionInternalView : View {
    /// {@link Binding} value of the {@link PresentationMode}.
    @Environment(\.presentationMode) fileprivate var presentationMode: Binding<PresentationMode>
    /// Chip search.
    var chipSearch: Binding<String>?
    /// Value of the title.
    let title: LocalizedStringKey
    /// Instance of the {@link ChipSection}.
    @Binding var sections: [ChipSection]
    
    /// Instance of the {@link View}.
    public var body: some View {
        let view = NavigationView {
            List {
                if chipSearch == nil || chipSearch!.wrappedValue.isEmpty == true {
                    ForEach($sections, id: \.id) {
                        SectionView(
                            section: $0,
                            isRemovable: false,
                            isNeedLimits: false,
                            moreClick: nil,
                            expandCallback: { onExpandClicked($0) }
                        )
                    }
                } else {
                    ChipsView(
                        chips: getChips(filter: chipSearch?.wrappedValue),
                        isRemovable: false,
                        isNeedLimits: false,
                        click: { onClicked($0, $1) },
                        moreClick: nil
                    )
                }
            }
            .animation(nil)
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button { presentationMode.wrappedValue.dismiss() } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
            .accentColor(ChipsConfiguration.tint)
        }
        // Add searchable.
        if #available(iOS 15.0, *) {
            if chipSearch != nil {
                view.searchable(text: chipSearch!)
            } else {
                view
            }
        } else {
            view
        }
    }
    
    /// Method which provide to get chips.
    /// - Parameter filter: value.
    /// - Returns: array of the chips.
    private func getChips(filter: String?) -> [Chip] {
        guard let filter = filter else {
            return sections.flatMap { $0.chips }
        }
        return sections
            .flatMap { $0.chips }
            .filter { $0.title.stringKey?.lowercased().contains(filter.lowercased()) == true }
    }
    
    /// Method which provide the action clicked.
    /// - Parameter chip: instance.
    private func onClicked(_ chip: Chip?, _ section: ChipSection?) {
        guard let chip = chip else { return }
        for i in 0..<sections.count {
            for j in 0..<sections[i].chips.count {
                if sections[i].chips[j].id == chip.id {
                    sections[i].chips[j].isSelected.toggle()
                }
            }
        }
    }
    
    /// Method which provide the expand callback functional.
    /// - Parameter section: instance.
    private func onExpandClicked(_ section: ChipSection?) {
        for i in 0..<sections.count {
            if sections[i].id != section?.id {
                sections[i].isExpanded = false
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
    let chipSearch: Binding<String>?
    /// Value of the title.
    let title: LocalizedStringKey
    /// Instance of the {@link ChipSection}.
    var sections: Binding<[ChipSection]>
    
    /// Default constructor.
    /// - Parameters:
    ///   - isPresented: is presented.
    ///   - title: value.
    ///   - sections: sections array.
    public init(
        isPresented: Binding<Bool>,
        chipSearch: Binding<String>?,
        title: LocalizedStringKey,
        sections: Binding<[ChipSection]>
    ) {
        self.isPresented = isPresented
        self.chipSearch = chipSearch
        self.title = title
        self.sections = sections
    }
    
    /// Instance of the {@link View}.
    public var body: some View {
        fullCover(isPresented: isPresented) {
            ChipsSelectionInternalView(
                chipSearch: chipSearch,
                title: title,
                sections: sections
            )
        }
    }
}
