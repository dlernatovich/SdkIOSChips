//
//  File.swift
//  
//
//  Created by Dmitry Lernatovich on 27.03.2024.
//

import Foundation

/// Storage for the SDK chips.
internal final class SdkChipsStorage {
    
    /// Instance of the {@link SdkChipsStorage}.
    static let shared: SdkChipsStorage = .init()
    
    /// Instance of the {@link UserDefaults}.
    private let storage: UserDefaults? = .init(suiteName: "com.zasio.sdk.chips")
    
    /// Method which provide to get value for the {@link Chip}.
    /// - Parameters:
    ///   - it: chip instance.
    ///   - defaultValue: default value.
    /// - Returns: received value.
    func getValue(_ it: Chip, defaultValue: Bool) -> Bool { getValue(it.id, defaultValue: defaultValue) }
    
    /// Method which provide to get value for the {@link Chip}.
    /// - Parameters:
    ///   - it: chip instance.
    ///   - defaultValue: default value.
    /// - Returns: received value.
    func getValue(_ it: String, defaultValue: Bool?) -> Bool {
        guard let value = storage?.value(forKey: it) as? Bool else { return defaultValue ?? false }
        return storage?.bool(forKey: it) ?? defaultValue ?? false
    }
    
    /// Method which provide to set value.
    /// - Parameter it: chip instance.
    func setValue(_ it: Chip) { setValue(it.id, value: it.isSelected) }
    
    /// Method which provide to set value.
    /// - Parameters:
    ///   - it: id value.
    ///   - value: value.
    func setValue(_ it: String, value: Bool?) {
        storage?.set(value ?? false, forKey: it)
    }
    
}
