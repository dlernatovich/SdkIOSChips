import Foundation
import SwiftUI

//MARK: - Chip
/// Default implementation for the {@link Chip}.
@available(iOS 13.0, *)
public struct Chip : Identifiable, Hashable {
    public let id: String
    public let image: Image?
    public let title: LocalizedStringKey
    public var titleString: String { title.stringValue() }
    public var isSelected: Bool { didSet { SdkChipsStorage.shared.setValue(self) } }
    public func hash(into hasher: inout Hasher) { hasher.combine(id) }
}

//MARK: - Chip - Update
@available(iOS 13.0, *)
public extension Chip {
    
    /// Method which provide the selected functional.
    /// - Parameter selected: if it is selected.
    /// - Returns: instance.
    @discardableResult
    mutating func update(selected: Bool) -> Self {
        self.isSelected = selected
        return self
    }
    
    /// Method which provide to toggle selected.
    /// - Returns: instance.
    @discardableResult
    mutating func toggleSelected() -> Self {
        self.isSelected.toggle()
        return self
    }
    
}

//MARK: - Chip - Create
/// Extension which provide the create functional.
@available(iOS 13.0, *)
public extension Chip {
    
    /// Method which provide to create the model functional.
    /// - Parameters:
    ///   - id: value.
    ///   - image: value.
    ///   - title: value.
    ///   - selected: value.
    /// - Returns: model instance.
    static func create(
        id: String,
        image: Image? = nil,
        title: String,
        selected: Bool? = nil
    ) -> Chip {
        Self.create(id: id, image: image, title: LocalizedStringKey(title), selected: selected)
    }
    
    /// Method which provide to create the model functional.
    /// - Parameters:
    ///   - id: value.
    ///   - image: value.
    ///   - title: value.
    ///   - selected: value.
    /// - Returns: model instance.
    static func create(
        image: Image? = nil,
        title: LocalizedStringKey,
        selected: Bool? = nil
    ) -> Chip {
        Self.create(id: UUID().uuidString, image: image, title: title, selected: selected)
    }
    
    /// Method which provide to create the model functional.
    /// - Parameters:
    ///   - id: value.
    ///   - image: value.
    ///   - title: value.
    ///   - selected: value.
    /// - Returns: model instance.
    static func create(
        id: String,
        image: Image? = nil,
        title: LocalizedStringKey,
        selected: Bool? = nil
    ) -> Chip {
        Self.init(
            id: id,
            image: image,
            title: title,
            isSelected: SdkChipsStorage.shared.getValue(id, defaultValue: selected)
        )
    }
    
}

//MARK: - Chip - Constants
/// Extension which provide the constants for the chip.
@available(iOS 13.0, *)
internal extension Chip {
    
    /// Chip for more view.
    static var moreChip: Chip {
        Self.create(id: "37eb0e5a-6a7b-41e5-bb4d-b1fcff2d50ca", title: "")
    }
    
    /// Check if current chip is more.
    /// - Returns: check result.
    func isMoreChip() -> Bool { Self.moreChip.id == self.id }
    
}
