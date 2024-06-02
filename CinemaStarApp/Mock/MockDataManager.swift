// MockDataManager.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

final class MockDataLoader {
    public static let shared = MockDataLoader()

    private init() {}

    public func loadMockData(filename: String) -> Data? {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            print("Mock data file not found")
            return nil
        }

        do {
            let data = try Data(contentsOf: url)
            return data
        } catch {
            print("Error loading mock data: \(error)")
            return nil
        }
    }
}
