import SwiftUI

/// View which provide the wrapped horizontal stack.
internal struct WrappingHStack<Model, V>: View where Model: Hashable, V: View {
    
    /// Callback which provide the view generate.
    typealias ViewGenerator = (Model) -> V
    
    /// Array of the models.
    var models: [Model]
    /// View generator callback.
    var viewGenerator: ViewGenerator
    /// Horizontal spacing.
    var horizontalSpacing: CGFloat = 4
    /// Vertical spacing.
    var verticalSpacing: CGFloat = 4
    
    /// Total height value.
    @State private var totalHeight
    = CGFloat.zero       // << variant for ScrollView/List
    //    = CGFloat.infinity   // << variant for VStack
    
    /// Instance of the {@link View}.
    var body: some View {
        VStack {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
        .frame(height: totalHeight)// << variant for ScrollView/List
        //.frame(maxHeight: totalHeight) // << variant for VStack
    }
    
    /// Method which provide to generate content.
    /// - Parameter geometry: instance of the {@link GeometryProxy}.
    /// - Returns: instance of the {@link View},
    private func generateContent(in geometry: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        return ZStack(alignment: .topLeading) {
            ForEach(self.models, id: \.self) { models in
                viewGenerator(models)
                    .padding(.horizontal, horizontalSpacing)
                    .padding(.vertical, verticalSpacing)
                    .alignmentGuide(.leading, computeValue: { dimension in
                        if (abs(width - dimension.width) > geometry.size.width)
                        {
                            width = 0
                            height -= dimension.height
                        }
                        let result = width
                        if models == self.models.last! {
                            width = 0 //last item
                        } else {
                            width -= dimension.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {dimension in
                        let result = height
                        if models == self.models.last! {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }.background(viewHeightReader($totalHeight))
    }
    
    /// Method which provide to define the height.
    /// - Parameter binding: value.
    /// - Returns: instance of the {@link View}.
    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}
