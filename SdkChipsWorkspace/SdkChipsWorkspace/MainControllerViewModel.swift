import Foundation
import SwiftUI
import SdkChips

/// View model for the {@link MainController}.
class MainControllerViewModel : ObservableObject {
    @Published var chips: [ChipSection] = Constants.chips
    @Published var chipSearch: String = ""
    @Published var isShownSelection: Bool = false
}
