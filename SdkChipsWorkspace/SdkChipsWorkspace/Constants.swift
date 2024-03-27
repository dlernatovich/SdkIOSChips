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
                .create(id: "cc2d85ee-c369-43d8-9448-84ff85dea3f3", image: Image("material_inventory_2"), title: "Box", selected: true),
                .create(id: "2812df87-9939-4897-95fa-b5a317ad6229", image: Image("material_folder"), title: "File"),
                .create(id: "7d813a8d-3e88-40f6-a208-284df36afc25", image: Image("material_description"), title: "Document", selected: true)
            ], isExpanded: true),
            .create(id: "49cf9b5f-7750-44f2-8985-02217b5dda6e", title: "Schedule", chips: [
                .create(id: "9bc64bfe-f6f1-4fe0-9730-b06130de8a66", image: Image("calendar_month-calendar_month_fill1_symbol"),
                    title: "Last Month"),
                .create(id: "10da8375-e474-4f6d-9863-7f600de0b3dd", image: Image("assignment_ind-assignment_ind_fill1_symbol"), title: "Assigned"),
            ])
        ]
    }
    
}
