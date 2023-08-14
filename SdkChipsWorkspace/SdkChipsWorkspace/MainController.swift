//
//  MainController.swift
//  SdkChipsWorkspace
//

import Foundation
import SwiftUI
import UIKit
import SdkChips

/// View for the main controller.
struct MainControllerView : View {
    
    /// Instance of the {@link MainControllerViewModel}.
    @ObservedObject private var vm: MainControllerViewModel = .init()
    
    /// Instance of the {@link View}.
    var body: some View {
        ZStack {
            List {
                ChipsHeaderView(
                    sections: $vm.chips,
                    limit: nil,
                    tint: .orange,
                    corner: 8.0,
                    moreClick: { vm.isShownSelection.toggle() }
                )
            }
            ChipsSelectionView(
                isPresented: $vm.isShownSelection,
                chipSearch: $vm.chipSearch,
                title: LocalizedStringKey("Tags"),
                sections: $vm.chips,
                limit: nil,
                tint: .orange,
                corner: 8.0
            )
        }
        .navigationTitle(LocalizedStringKey("Main Screen"))
    }
    
}


/// Main Controller class.
class MainController : UIHostingController<MainControllerView> {
    
    /// Init functionalty.
    /// - Parameter aDecoder: instance of the {@link NSCoder}.
    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder, rootView: .init()) }
    
}
