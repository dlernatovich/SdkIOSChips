import Foundation
import SwiftUI

//MARK: - LocalizedStringKey
/// Extension for the {@link LocalizedStringKey}.
internal extension LocalizedStringKey {
    
    // This will mirror the `LocalizedStringKey` so it can access its
    // internal `key` property. Mirroring is rather expensive, but it
    // should be fine performance-wise, unless you are
    // using it too much or doing something out of the norm.
    var stringKey: String? {
        Mirror(reflecting: self).children.first(where: { $0.label == "key" })?.value as? String
    }
    
    /// Method which provide to get string value.
    /// - Parameter locale: value.
    /// - Returns: value.
    func stringValue(locale: Locale = .current) -> String {
        guard let key = self.stringKey else { return "" }
        return .localizedString(for: key, locale: locale)
    }
}

//MARK: - String
/// Extension for the {@link String}.
private extension String {
    
    /// Method which provide to get localized string.
    /// - Parameters:
    ///   - key: value.
    ///   - locale: value.
    /// - Returns: value.
    static func localizedString(
        for key: String,
        locale: Locale = .current
    ) -> String {
        let language = locale.languageCode
        guard let path = Bundle.main.path(forResource: language, ofType: "lproj") else { return key }
        guard let bundle = Bundle(path: path) else { return key }
        let localizedString = NSLocalizedString(key, bundle: bundle, comment: "")
        return localizedString
    }
}
