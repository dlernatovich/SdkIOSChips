import SwiftUI

/// Flexible item view.
internal struct FlexibleItem<Data: Collection, Content: View>: View where Data.Element: Hashable {
    /// Available width.
    let availableWidth: CGFloat
    /// Data to display.
    let data: Data
    /// Spacing.
    let spacing: CGFloat
    /// Alignment.
    let alignment: HorizontalAlignment
    /// Horizontal alignment.
    let content: (Data.Element) -> Content
    /// Element size.
    @State var elementsSize: [Data.Element: CGSize] = [:]
    
    /// Instance of the {@link View}.
    var body : some View {
        VStack(alignment: alignment, spacing: spacing) {
            ForEach(computeRows(), id: \.self) { rowElements in
                HStack(spacing: spacing) {
                    ForEach(rowElements, id: \.self) { element in
                        content(element).fixedSize().readSize { size in
                            elementsSize[element] = size
                        }
                    }
                }
            }
        }
    }
    
    /// Method which provide to compute rows.
    /// - Returns: computed elements.
    func computeRows() -> [[Data.Element]] {
        var rows: [[Data.Element]] = [[]]
        var currentRow = 0
        var remainingWidth = availableWidth
        
        for element in data {
            let elementSize = elementsSize[
                element,
                default: CGSize(width: availableWidth, height: 1)
            ]
            
            if remainingWidth - (elementSize.width + spacing) >= 0 {
                rows[currentRow].append(element)
            } else {
                currentRow = currentRow + 1
                rows.append([element])
                remainingWidth = availableWidth
            }
            
            remainingWidth = remainingWidth - (elementSize.width + spacing)
        }
        
        return rows
    }
}
