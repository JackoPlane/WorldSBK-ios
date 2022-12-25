//
//  NotImplementedError.swift
//  TrackMap
//
//  Created by Jack Perry on 23/12/2022.
//

import Foundation

/// Unconditionally prints `"Not implemented"` and stops execution.
public func notImplementedError(_ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) -> Never {
    if let message = message().ifNotEmpty {
        fatalError("Not implemented: \(message)", file: file, line: line)
    } else {
        fatalError("Not implemented", file: file, line: line)
    }
}

public func subclassMustOverrideError(_ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) -> Never {
    if let message = message().ifNotEmpty {
        fatalError("Subclass must override: \(message)", file: file, line: line)
    } else {
        fatalError("Subclass must override", file: file, line: line)
    }
}

public extension Collection {

    /// Returns the count of elements where the predicate returns `true`.
    ///
    /// - Note: This method is oddly named to avoid confusion for the typechecker.
    ///         This method has been approved by Swift Evolution but blocked for
    ///         the same reason.
    ///
    /// - Parameter predicate: The predicate required to pass.
    func countWhere(_ predicate: (Element) -> Bool) -> Int {
        reduce(into: 0) {
            if predicate($1) {
                $0 += 1
            }
        }
    }

    var ifNotEmpty: Self? {
        isEmpty ? nil : self
    }

}
