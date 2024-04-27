// ImageRequest.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

final class ImageRequest {
    let url: URL

    init(url: URL) {
        self.url = url
    }
}

extension ImageRequest: NetworkRequest {
    func decode(_ data: Data) -> UIImage? {
        UIImage(data: data)
    }

    func execute(withCompletion completion: @escaping (UIImage?) -> Void) {
        load(url, withCompletion: completion)
    }
}
