import Foundation
import SwiftUI

//MARK: - ChipSectionModel
/// Implementation for the {@link ChipSection}.
@available(iOS 13.0, *)
public struct ChipSection : Identifiable, Hashable {
    public var id: String
    public let title: LocalizedStringKey
    public var chips: [Chip]
    public func hash(into hasher: inout Hasher) { hasher.combine(id) }
    internal var crc: String = UUID().uuidString
    private var settings: ChipSectionContainer { .shared }
}

//MARK: - ChipSectionModel - Getters
/// Extension which provide the getters functional.
public extension ChipSection {
    
    /// {@link Bool} value if it was expanded.
    var isExpanded: Bool {
        get { settings.get(id: id) }
        set { settings.set(id: id, value: newValue) { crc = UUID().uuidString } }
    }
    
    /// Method which provide to get selected chips.
    func getSelectedChips() -> [Chip] { chips.filter { $0.isSelected == true } }
    
    /// Method which provide to get the selected count.
    func getSelectedCount() -> Int { getSelectedChips().count }
    
    /// Method which provide to check if has selected items.
    func isHasSelected() -> Bool { getSelectedCount() > 0 }
    
}

//MARK: - ChipSectionModel - Create
/// Extension which provide to create functional.
@available(iOS 13.0, *)
public extension ChipSection {
    
    /// Method which provide the create functional.
    /// - Parameters:
    ///   - title: value.
    ///   - chips: array.
    /// - Returns: value of the {@link ChipSectionModel}.
    static func create(
        title: String,
        chips: [Chip],
        isExpaded: Bool = false
    ) -> ChipSection {
        Self.create(id: UUID().uuidString, title: title, chips: chips, isExpanded: isExpaded)
    }
    
    /// Method which provide the create functional.
    /// - Parameters:
    ///   - id: value.
    ///   - title: value.
    ///   - chips: array.
    /// - Returns: value of the {@link ChipSectionModel}.
    static func create(
        id: String,
        title: String,
        chips: [Chip],
        isExpanded: Bool = false
    ) -> ChipSection {
        Self.create(id: id, title: LocalizedStringKey(title), chips: chips, isExpanded: isExpanded)
    }
    
    /// Method which provide the create functional.
    /// - Parameters:
    ///   - title: value.
    ///   - chips: array.
    /// - Returns: value of the {@link ChipSectionModel}.
    static func create(
        title: LocalizedStringKey,
        chips: [Chip],
        isExpanded: Bool = false
    ) -> ChipSection {
        Self.create(id: UUID().uuidString, title: title, chips: chips, isExpanded: isExpanded)
    }
    
    /// Method which provide the create functional.
    /// - Parameters:
    ///   - id: value.
    ///   - title: value.
    ///   - chips: array.
    /// - Returns: value of the {@link ChipSectionModel}.
    static func create(
        id: String,
        title: LocalizedStringKey,
        chips: [Chip],
        isExpanded: Bool = false
    ) -> ChipSection {
        var chip = ChipSection(id: id, title: title, chips: chips)
        chip.isExpanded = isExpanded
        return chip
    }
    
}

//MARK: - ChipSection - Constants
/// Method which provide the constants of the chip section.
@available(iOS 13.0, *)
internal extension ChipSection {
    
    /// Chip for more view.
    static var moreChip: ChipSection {
        Self.create(id: "a517388f-5c33-4d0a-af8c-09ca513a78dc", title: "", chips: [])
    }
    
    /// Check if current chip is more.
    /// - Returns: check result.
    func isMoreChip() -> Bool { Self.moreChip.id == self.id }
    
}

//MARK: - ChipSectionContainer
/// Container for the {@link ChipSection}.
private class ChipSectionContainer {
    
    /// Instance of the {@link ChipSectionContainer}.
    static let shared: ChipSectionContainer = .init()
    
    /// Instance of the {@link UserDefaults}.
    private let settings = UserDefaults(suiteName: "b4fb28ec-9e19-416f-a6aa-8818940bc86d")
    
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
