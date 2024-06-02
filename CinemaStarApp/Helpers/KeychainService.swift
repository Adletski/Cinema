// KeychainService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import KeychainSwift

// swiftlint:disable all
protocol KeyChainProtocol: AnyObject {
    func saveToken(_ token: String, forKey key: String)
    func loadToken(forKey key: String) -> String?
    func deleteToken(forKey key: String)
}

final class KeyChain: KeyChainProtocol {
    private let keychain = KeychainSwift()

    func saveToken(_ token: String, forKey key: String) {
        keychain.set(token, forKey: key)
    }

    func loadToken(forKey key: String) -> String? {
        keychain.get(key)
    }

    func deleteToken(forKey key: String) {
        keychain.delete(key)
    }
}

// swiftlint:enable all
