import Foundation
import SwiftUI
import SdkChips

/// View model for the {@link MainController}.
class MainControllerViewModel : ObservableObject {
    @Published var chips: [ChipSection] = Constants.chips
    @Published var isGrouped: Bool = false
    @Published var isClosable: Bool = false
    @Published var limit: Int? = nil
}
