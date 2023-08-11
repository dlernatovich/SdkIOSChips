import Foundation
import SwiftUI
import SdkChips

/// Class which provide the constants for the application.
final class Constants {
    
    /// Shared instance of the {@link Constants}.
    private static let shared: Constants = .init()
    
    /// Array of the chips constants.
    static var chips: [ChipSection] { shared.chips }
    
    /// Internal array of the chips.
    private var chips: [ChipSection] {
        [
            .create(title: "One", chips: [
                .create(id: UUID().uuidString, image: nil, title: "Chip 1"),
                .create(id: UUID().uuidString, image: nil, title: "Chip 2"),
                .create(id: UUID().uuidString, image: nil, title: "Chip 3"),
                .create(id: UUID().uuidString, image: nil, title: "Chip 1"),
                .create(id: UUID().uuidString, image: nil, title: "Chip 2"),
                .create(id: UUID().uuidString, image: nil, title: "Chip 3"),
                .create(id: UUID().uuidString, image: nil, title: "Chip 1", selected: true),
                .create(id: UUID().uuidString, image: nil, title: "Chip 2"),
                .create(id: UUID().uuidString, image: nil, title: "Chip 3", selected: true),
                .create(id: UUID().uuidString, image: nil, title: "Chip 1"),
                .create(id: UUID().uuidString, image: nil, title: "Chip 2"),
                .create(id: UUID().uuidString, image: nil, title: "Chip 3", selected: true),
                .create(id: UUID().uuidString, image: nil, title: "Chip 1", selected: true),
                .create(id: UUID().uuidString, image: nil, title: "Chip 2", selected: true),
                .create(id: UUID().uuidString, image: nil, title: "Chip 3", selected: true),
                .create(id: UUID().uuidString, image: nil, title: "Chip 1"),
                .create(id: UUID().uuidString, image: nil, title: "Chip 2"),
                .create(id: UUID().uuidString, image: nil, title: "Chip 3", selected: true),
            ]),
            .create(title: "Two", chips: [
                .create(
                    id: UUID().uuidString,
                    image: Image(systemName: "text.book.closed.fill"),
                    title: "Chip 5"
                ),
                .create(id: UUID().uuidString, image: nil, title: "Chip 6"),
                .create(id: UUID().uuidString, image: nil, title: "Chip 7", selected: true),
                .create(id: UUID().uuidString, image: nil, title: "Chip 8", selected: true),
                .create(id: UUID().uuidString, image: nil, title: "Chip 9"),
                .create(id: UUID().uuidString, image: nil, title: "Chip 10", selected: true)
            ]),
            .create(title: "Three", chips: [
                .create(id: UUID().uuidString, image: nil, title: "Chip 11"),
            ])
        ]
    }
    
}
