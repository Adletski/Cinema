// ViewState.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// ViewState
enum ViewState<Model> {
    case loading
    case data(Model)
    case noData
    case error(_ error: Error)
}
