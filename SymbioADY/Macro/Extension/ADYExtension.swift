//
//  ADYExtension.swift
//  SymbioADY
//
//  Created by ady on 2023/8/9.
//

import Foundation

public struct Ady<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol AdyCompatible {
    associatedtype Compatible
    static var `ady`: Ady<Compatible>.Type { get }
    var `ady`: Ady<Compatible> { get }
}

extension AdyCompatible {
    public static var `ady`: Ady<Self>.Type {
        return Ady<Self>.self
    }
    public var `ady`: Ady<Self> {
        return Ady(self)
    }
}
