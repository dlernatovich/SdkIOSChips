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
        chips: [Chip]
    ) -> ChipSection {
        return Self.create(id: UUID().uuidString, title: title, chips: chips)
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
        chips: [Chip]
    ) -> ChipSection {
        return Self.create(id: id, title: LocalizedStringKey(title), chips: chips)
    }
    
    /// Method which provide the create functional.
    /// - Parameters:
    ///   - title: value.
    ///   - chips: array.
    /// - Returns: value of the {@link ChipSectionModel}.
    static func create(
        title: LocalizedStringKey,
        chips: [Chip]
    ) -> ChipSection {
        return Self.create(id: UUID().uuidString, title: title, chips: chips)
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
        chips: [Chip]
    ) -> ChipSection {
        return ChipSection(id: id, title: title, chips: chips)
    }
    
}
