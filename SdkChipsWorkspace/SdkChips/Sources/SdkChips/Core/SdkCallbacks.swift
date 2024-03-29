import Foundation
import SwiftUI

/// Chips click callback.
internal typealias ChipClickCallback = (_ chip: Chip?, _ section: ChipSection?) -> Void
/// More chip click callback.
public typealias MoreClickCallback = () -> Void
/// Expand callback.
internal typealias ExpandCallback = (_ section: ChipSection) -> Void
