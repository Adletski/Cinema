// NetworkRequest.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import KeychainSwift

protocol NetworkRequest: AnyObject {
    associatedtype ModelType
    func decode(_ data: Data) -> ModelType?
    func execute(withCompletion completion: @escaping (ModelType?) -> Void)
}

extension NetworkRequest {
    func load(_ url: URL, withCompletion completion: @escaping (ModelType?) -> Void) {
        var request = URLRequest(url: url)

//        let keyChain = KeychainSwift()
//        guard let token = keyChain.get("APIToken") else { return }

        guard let data = KeychainService.shared.load(key: "APIToken") else { return }
        let token = String(data: data, encoding: .utf8)

        request.setValue(token, forHTTPHeaderField: "X-API-KEY")
        URLSession.shared.dataTask(with: request) { [weak self] data, _, _ in
            guard let data = data, let value = self?.decode(data) else {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            DispatchQueue.main.async { completion(value) }
        }.resume()
    }
}
