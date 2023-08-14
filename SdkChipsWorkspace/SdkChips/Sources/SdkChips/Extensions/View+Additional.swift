import Foundation
import SwiftUI

/// View which provide to put invisible view for dialog, alert, actionSheet.
internal struct InvisibleView: View {
    /// Instance of the {@link View}.
    public var body: some View { Rectangle().frame(width: 1, height: 1).opacity(0.01) }
}

/// Extension which provide for view display dialogs, alert, actionSheet.
internal extension View {
    
    /// Method which provide to create view for displaying the action sheet for view.
    /// - Parameters:
    ///   - isPresented: instance of the {@link Binding}.
    ///   - content: escaping content.
    /// - Returns: instance of the {@link View}.
    func viewSheet<Content>(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) -> some View where Content : View {
        return InvisibleView().sheet(isPresented: isPresented, content: content)
    }
    
    /// Method which provide to create view for displaying the action sheet for view.
    /// - Parameters:
    ///   - isPresented: instance of the {@link Binding}.
    ///   - content: escaping content.
    /// - Returns: instance of the {@link View}.
    func fullCover<Content>(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) -> some View where Content : View {
        return InvisibleView().fullScreenCover(isPresented: isPresented, content: content)
    }
    
}
