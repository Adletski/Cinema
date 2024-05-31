// AppDelegate.swift
// Copyright © RoadMap. All rights reserved.

import CoreData
import KeychainSwift
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        if let data = "3AR0DZH-TT3MA8B-H6CAPDJ-FM50BPH".data(using: .utf8) {
            let _ = KeychainService.shared.save(key: "APIToken", data: data)
        }
//        let keychain = KeychainSwift()
//        keychain.set("3AR0DZH-TT3MA8B-H6CAPDJ-FM50BPH", forKey: "APIToken")
        return true
    }
}
