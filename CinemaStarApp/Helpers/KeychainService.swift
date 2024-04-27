// KeychainService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import Security

// swiftlint:disable all
final class KeychainService {
    static let shared = KeychainService()

    private init() {}

    func save(key: String, data: Data) -> OSStatus {
        let query = [
            kSecClass as String: kSecClassGenericPassword as String,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ] as [String: Any]

        SecItemDelete(query as CFDictionary) // Удаляет старый элемент, если он существует
        return SecItemAdd(query as CFDictionary, nil)
    }

    func load(key: String) -> Data? {
        let query = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ] as [String: Any]

        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        if status == noErr {
            return item as? Data
        }
        return nil
    }

    func delete(key: String) -> OSStatus {
        let query = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ] as [String: Any]

        return SecItemDelete(query as CFDictionary)
    }
}

// swiftlint:enable all
