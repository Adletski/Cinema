// Extension+Image.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Image
extension Image {
    init?(data: Data) {
        guard let image = UIImage(data: data) else { return nil }
        self = .init(uiImage: image)
            .resizable()
    }
}
