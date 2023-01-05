//
//  Sequence+SortedKeyPath.swift
//  TrackMap
//
//  Created by Jack Perry on 26/12/2022.
//

import Foundation

extension Sequence {
    func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        return sorted { a, b in
            return a[keyPath: keyPath] < b[keyPath: keyPath]
        }
    }
}
