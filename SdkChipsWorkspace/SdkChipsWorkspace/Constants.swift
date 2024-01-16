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
            .create(id: "fa04d788-e212-4244-945d-c1f75d537d5b", title: "Type", chips: [
                .create(id: UUID().uuidString, image: Image("material_inventory_2"), title: "Box", selected: true),
                .create(id: UUID().uuidString, image: Image("material_folder"), title: "File"),
                .create(id: UUID().uuidString, image: Image("material_description"), title: "Document", selected: true)
            ], isExpanded: true),
            .create(id: "49cf9b5f-7750-44f2-8985-02217b5dda6e", title: "Schedule", chips: [
                .create(id: UUID().uuidString, image: Image("calendar_month-calendar_month_fill1_symbol"),
                    title: "Last Month"),
                .create(id: UUID().uuidString, image: Image("assignment_ind-assignment_ind_fill1_symbol"), title: "Assigned"),
            ])
        ]
    }
    
}
