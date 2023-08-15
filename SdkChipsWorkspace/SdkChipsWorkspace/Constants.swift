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
                .create(id: UUID().uuidString, image: nil, title: "One - Chip 1"),
                .create(id: UUID().uuidString, image: nil, title: "One - Chip 2"),
                .create(id: UUID().uuidString, image: nil, title: "One - Chip 3"),
                .create(id: UUID().uuidString, image: nil, title: "One - Chip 4"),
                .create(id: UUID().uuidString, image: nil, title: "One - Chip 5"),
                .create(id: UUID().uuidString, image: nil, title: "One - Chip 6"),
                .create(id: UUID().uuidString, image: nil, title: "One - Chip 7", selected: true),
                .create(id: UUID().uuidString, image: nil, title: "One - Chip 8"),
                .create(id: UUID().uuidString, image: nil, title: "One - Chip 9", selected: true),
                .create(id: UUID().uuidString, image: nil, title: "One - Chip 10"),
                .create(id: UUID().uuidString, image: nil, title: "One - Chip 11"),
                .create(id: UUID().uuidString, image: nil, title: "One - Chip 12", selected: true),
                .create(id: UUID().uuidString, image: nil, title: "One - Chip 13", selected: true),
                .create(id: UUID().uuidString, image: nil, title: "One - Chip 14", selected: true),
                .create(id: UUID().uuidString, image: nil, title: "One - Chip 15", selected: true),
                .create(id: UUID().uuidString, image: nil, title: "One - Chip 16"),
                .create(id: UUID().uuidString, image: nil, title: "One - Chip 17"),
                .create(id: UUID().uuidString, image: nil, title: "One - Chip 18", selected: true),
            ]),
            .create(title: "Two", chips: [
                .create(
                    id: UUID().uuidString,
                    image: Image(systemName: "text.book.closed.fill"),
                    title: "Two - Chip 1"
                ),
                .create(id: UUID().uuidString, image: nil, title: "Two - Chip 2"),
                .create(id: UUID().uuidString, image: nil, title: "Two - Chip 3", selected: true),
                .create(id: UUID().uuidString, image: nil, title: "Two - Chip 4", selected: true),
                .create(id: UUID().uuidString, image: nil, title: "Two - Chip 5"),
                .create(id: UUID().uuidString, image: nil, title: "Two - Chip 6", selected: true)
            ]),
            .create(title: "Three", chips: [
                .create(id: UUID().uuidString, image: nil, title: "Three - Chip 1"),
            ])
        ]
    }
    
}
