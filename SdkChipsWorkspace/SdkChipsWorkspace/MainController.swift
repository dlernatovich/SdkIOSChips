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
        List {
            if vm.isGrouped == true {
                ForEach($vm.chips, id: \.id) { $section in
                    SectionView(
                        section: $section,
                        isRemovable: vm.isClosable,
                        limit: vm.limit,
                        tint: .green,
                        corner: 8.0
                    )
                }
            } else {
                SectionsMultilineView(
                    sections: $vm.chips,
                    isRemovable: vm.isClosable,
                    limit: vm.limit,
                    tint: .green,
                    corner: 8.0
                )
            }
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
